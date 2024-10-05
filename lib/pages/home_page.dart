import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/controllers/post_controller.dart';
import 'package:persist_ventures_asn/shared/navigation_helper.dart';
import 'package:persist_ventures_asn/widgets/c_text.dart';
import 'package:persist_ventures_asn/widgets/content_card.dart';

import '../shared/colors.dart';
import 'create_post_page.dart';
import 'profile_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final PostController postController = Get.put(PostController());
  final commentController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 1) {
      } else if (_selectedIndex == 2) {
        goNextPage(const CreatePostPage());
      } else if (_selectedIndex == 3) {
      } else if (_selectedIndex == 4) {
        goNextPage(const ProfileDetailsPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/images/lg.png",
            width: 200,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                size: 28,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/images/badge.png",
              width: 28,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: postController.getPostsStream(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No posts found.'));
            } else {
              List<Map<String, dynamic>> posts =
                  snapshot.data!.reversed.toList();

              return ListView.builder(
                itemCount: posts.length,
                shrinkWrap: true,
                primary: false,
                // reverse: true,
                //maxscrollextent
                itemBuilder: (BuildContext context, int index) {
                  var post = posts[index];
                  User? user = _auth.currentUser;

                  return ContentCard(
                    creatorName: post['username'] ?? " No Name",
                    creatorDescription: post['bio'] ?? "",
                    creatorProfileImage:
                        post['profileImage'] ?? 'https://picsum.photos/200/300',
                    postCaption: post['description'],
                    accountOwnerImagePath:
                        user?.photoURL ?? 'https://picsum.photos/200/300',
                    postImagePath: post['postImage'],
                    color: post['likes'].contains(user?.uid) ? red : grey800,
                    addLike: () {
                      post['likes'].contains(user?.uid)
                          ? postController.removeLike(post['postId'], user!.uid)
                          : postController.addLike(post['postId'], user!.uid);
                    },
                    addComment: () {
                      // want to show a modal
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const CText("Add Comment"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 13.0,
                                        //   backgroundImage: NetworkImage(''),
                                        // ),
                                        const SizedBox(width: 16.0),
                                        Expanded(
                                          child: TextField(
                                            // readOnly: true,

                                            controller: commentController,
                                            showCursor: false,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Add a comment',
                                              hintStyle: TextStyle(
                                                fontSize: 13,
                                                color: grey500,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.send),
                                          iconSize: 25,
                                          onPressed: () {
                                            if (commentController
                                                .text.isNotEmpty) {
                                              postController.addComment(
                                                post['postId'],
                                                commentController.text,
                                              );

                                              commentController.clear();
                                              // Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                  stream: postController
                                      .getCommentsStream(post['postId']),
                                  // initialData: initialData,

                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text('No comments found.'));
                                    } else {
                                      var comments = snapshot.data!;

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        reverse: true,
                                        primary: false,
                                        itemCount: comments.length ?? 0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var comment = comments[index];

                                          return ListTile(
                                            leading: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  comment['profileImage'] ??
                                                      'https://picsum.photos/200/300'),
                                            ),
                                            title: Text(comment['username']),
                                            subtitle: Text(comment['comment']),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              );

              // return ListView.builder(
              //   itemCount: posts.length,
              //   itemBuilder: (context, index) {
              //     var post = posts[index];
              //     return Card(
              //       child: ListTile(
              //         leading: post['userImage'] != null
              //             ? Image.network(post['userImage'],
              //                 width: 50, height: 50, fit: BoxFit.cover)
              //             : Icon(Icons.person,
              //                 size: 50), // Placeholder if no image
              //         title: Text(post['title'] ?? 'No Title'),
              //         subtitle: Text(post['description'] ?? 'No Description'),
              //       ),
              //     );
              //   },
              // );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: deeporrange,
          unselectedItemColor: grey500,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedIconTheme: IconThemeData(color: deeporrange),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/home-button.png",
                color: deeporrange,
                height: 22,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/search.png",
                height: 22,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/add.png",
                height: 22,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/chat.png",
                height: 22,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(_auth.currentUser!.photoURL ??
                    "https://picsum.photos/200/300?random=1"),
              ),
              label: '',
            ),
          ],
        ));
  }
}
