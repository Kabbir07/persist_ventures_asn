import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/widgets/my_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String bio = "App User";

  Future<void> signUpWithEmailAndPassword(name, email, password) async {
    myLoading();
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.back();
      Get.offAll(const HomePage(),
          transition: Transition.rightToLeft, duration: 500.milliseconds);
      if (userCredential.user != null) {
        Get.snackbar("Success", "Account created successfully");

        User? user = userCredential.user;

        if (user != null) {
          await user.updateDisplayName(name);
          await user.updatePhotoURL('https://picsum.photos/200/300');
          await user.reload();
        }
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString());
    }
  }

  // method to sign in the user
  Future<void> signInWithEmailAndPassword(email, password) async {
    myLoading();
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.back();
      if (userCredential.user != null) {
        Get.back();
        // Get.snackbar("Success", "Login successful");
        Get.offAll(const HomePage(),
            transition: Transition.rightToLeft, duration: 500.milliseconds);
      }
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> saveUserDetails(name, User user) async {
    try {
      // Check if user already exists
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // Save user details (email, uid, etc.) to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'uid': user.uid,
          'username': name,
          'bio': bio,
          'profileImage': user.photoURL ?? 'default_image_url',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print("Error saving user details: $e");
    }
  }

  // Method to check if a user is logged in
  Future<bool> isUserLoggedIn() async {
    try {
      User? user = _auth.currentUser;
      return user != null;
    } catch (e) {
      print('Error checking user login status: $e');
      return false;
    }
  }

  // method to sign out the user
  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await _auth.signOut();
      await prefs.remove('name');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
