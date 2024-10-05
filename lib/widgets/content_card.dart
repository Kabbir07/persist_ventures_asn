// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/controllers/post_controller.dart';
import 'package:readmore/readmore.dart';

import '../shared/colors.dart';
import 'c_text.dart';

class ContentCard extends StatelessWidget {
  final String creatorProfileImage;
  final String creatorName;
  final String creatorDescription;
  final String postCaption;
  final String postImagePath;
  final String accountOwnerImagePath;
  Color color;
  // callback function to add like
  void Function()? addLike;

  // function to add comment
  void Function()? addComment;

  // constructor
  ContentCard({
    Key? key,
    required this.creatorProfileImage,
    required this.creatorName,
    required this.creatorDescription,
    required this.postCaption,
    required this.postImagePath,
    required this.accountOwnerImagePath,
    required this.color,
    this.addLike,
    this.addComment,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: grey100, borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(creatorProfileImage ?? ''),
              ),
              title:
                  CText(creatorName ?? '', size: 16, weight: FontWeight.bold),
              subtitle: CText(
                creatorDescription ?? '',
                size: 14,
                color: grey500,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ReadMoreText(
                postCaption ?? '',
                trimMode: TrimMode.Line,
                trimLines: 1,
                colorClickableText: Colors.pink,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(postImagePath ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      addLike!();
                    },
                    child: Image.asset(
                      "assets/icons/love.png",
                      height: 22,
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/chat-bubble.png",
                      height: 22,
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/send.png",
                      height: 20,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/icons/bookmark.png",
                      height: 23,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 13.0,
                      backgroundImage:
                          NetworkImage(accountOwnerImagePath ?? ''),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          addComment!();
                        },
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
