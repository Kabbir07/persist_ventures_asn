import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/controllers/auth_controller.dart';
import 'package:persist_ventures_asn/pages/home_page.dart';
import 'package:persist_ventures_asn/widgets/my_loading.dart';

class PostController extends GetxController {
  final AuthController _authController = Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadImage(image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> uploadData(imagefile, title, desc) async {
    myLoading();
    // String name = await _authController.getCUserName();
    if (imagefile != null) {
      String? imageUrl = await uploadImage(imagefile!);

      if (imageUrl != null) {
        CollectionReference posts =
            FirebaseFirestore.instance.collection('posts');

        // Add the post to Firestore and get the DocumentReference
        DocumentReference docRef = await posts.add({
          'userId': _auth.currentUser!.uid,
          'username': _auth.currentUser!.displayName,
          'profileImage': _auth.currentUser!.photoURL,
          'bio': 'App Developer',
          'postImage': imageUrl,
          'title': title,
          'description': desc,
          'likes': [], // Initialize with an empty list of likes
          'comments': [], // Initialize with an empty list of comments
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Get the auto-generated document ID and update the document with it
        String postId = docRef.id;

        await docRef.update({
          'postId': postId, // Update the document with the generated postId
        });

        Get.back();

        Get.snackbar("Success", "Data uploaded successfully");
        Get.offAll(() => const HomePage(),
            transition: Transition.rightToLeft, duration: 500.milliseconds);
      } else {
        Get.back();
        Get.snackbar("Error", "Failed to upload image");
      }
    }
  }

  // add likes
  Future<void> addLike(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  // remove likes
  Future<void> removeLike(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([userId])
    });
  }

  // add comments
  Future<void> addComment(String postId, String comment) async {
    // Create a new comment without the server timestamp
    Map<String, dynamic> commentData = {
      'comment': comment,
      'userId': _auth.currentUser!.uid,
      'username': _auth.currentUser!.displayName,
      'profileImage': _auth.currentUser!.photoURL,
      // 'timestamp': FieldValue.serverTimestamp(), // Placeholder for now
      // use another timestamp for server timestamp
      'timestamp': DateTime.now().millisecondsSinceEpoch, // Placeholder for now
    };

    // First, add the comment without serverTimestamp
    await _firestore.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([commentData])
    });
  }

  // get all comments
  Stream<List<dynamic>> getCommentsStream(String postId) {
    return _firestore
        .collection('posts')
        .doc(postId)
        .snapshots()
        .map((snapshot) => snapshot.data()!['comments']);
  }

  // Fetch all posts from Firestore
  Stream<List<Map<String, dynamic>>> getPostsStream() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

// filter my post using my uid
  Stream<List<Map<String, dynamic>>> getMyPostsStream() {
    return _firestore
        .collection('posts')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
