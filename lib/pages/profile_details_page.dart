import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/pages/signin_page.dart';
import 'package:persist_ventures_asn/shared/colors.dart';
import 'package:persist_ventures_asn/widgets/c_text.dart';

import '../controllers/auth_controller.dart';
import '../controllers/post_controller.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final _authController = Get.find<AuthController>();
  final _postCotroller = Get.find<PostController>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  int postLength = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ListTile(
                title: const Text("Logout"),
                trailing: const Icon(Icons.logout),
                onTap: () {
                  _authController.signOut();
                  Get.offAll(const SigninPage(),
                      transition: Transition.leftToRight,
                      duration: 500.milliseconds);
                })
          ],
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
// circle avatar
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(_auth.currentUser!.photoURL ??
                "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png"),
          ),
          const SizedBox(
            height: 10,
          ),

// name
          Text(
            _auth.currentUser!.displayName!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          const Text(
            "Software Engineer",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

// followers, following, posts
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    CText(
                      postLength.toString(),
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    CText(
                      "Post",
                      weight: FontWeight.w500,
                      size: 12,
                      color: grey500,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                child: Column(
                  children: [
                    const CText(
                      "15",
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    CText(
                      "Followers",
                      weight: FontWeight.w500,
                      size: 12,
                      color: grey500,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                child: Column(
                  children: [
                    CText(
                      "15",
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    CText(
                      "Following",
                      weight: FontWeight.w500,
                      size: 12,
                      color: grey500,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),

// Edit profile, create post card

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: grey200, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/edit.png",
                        height: 20,
                        color: grey800,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CText(
                        "Edit Profile",
                        weight: FontWeight.bold,
                        color: grey800,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: grey200, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/write.png",
                        height: 20,
                        color: grey800,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CText(
                        "Create Postcard",
                        weight: FontWeight.bold,
                        color: grey800,
                        size: 12,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
// for tab bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _onItemTapped(0);
                },
                child: Icon(
                  Icons.grid_view_outlined,
                  size: 20,
                  color: _selectedIndex == 0 ? deeporrange : grey800,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () {
                  _onItemTapped(1);
                },
                child: Image.asset(
                  "assets/icons/bookmark.png",
                  height: 20,
                  color: _selectedIndex == 1 ? deeporrange : grey800,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
// grid view
          Expanded(
            child: Container(
              // height: double.infinity,.
              // color: Colors.amber,
              child: _selectedIndex == 0
                  ? StreamBuilder<List<Map<String, dynamic>>>(
                      stream: _postCotroller.getMyPostsStream(),
                      builder: (context, snapshot) {
                        // Check if the stream has data
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Show loading indicator while waiting for data
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // Handle error state
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          // Handle case where no data is available
                          return Text('No posts available');
                        } else {
                          // Capture the list of posts
                          List<Map<String, dynamic>> myPosts = snapshot.data!;

                          postLength = myPosts.length;

                          // You can now use the 'myPosts' variable to display the posts in the UI
                          return GridView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: myPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: grey200,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          myPosts[index]['postImage'] ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: grey200,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
