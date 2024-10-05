import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persist_ventures_asn/controllers/post_controller.dart';
import 'package:persist_ventures_asn/shared/colors.dart';
import 'package:persist_ventures_asn/widgets/c_text.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [5, 5],
                  color: grey500,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: grey100,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: grey300),
                    ),
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.fill)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/upload.png",
                                height: 30,
                                color: grey800,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CText(
                                'Upload a Image here',
                                size: 14,
                                weight: FontWeight.bold,
                                color: grey800,
                                decoration: TextDecoration.underline,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              CText(
                                "JPG or PNG file size not more than 10MB",
                                size: 12,
                                color: grey500,
                              )
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // event title
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Event Title",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              // event title text field
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: grey300, width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIconColor: grey500,
                    hintStyle: TextStyle(
                      color: grey500,
                      fontSize: 12,
                    ),
                    hintText: "Post title",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // event description
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Description",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              // event description text field
              SizedBox(
                height: 130,
                child: TextField(
                  controller: _descController,
                  expands: true,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: grey300, width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIconColor: grey500,
                    hintStyle: TextStyle(
                      color: grey500,
                      fontSize: 14,
                    ),
                    hintText: "Write a description",
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),

              // const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: deeporrange,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              onPressed: () {
                _validateFields();
              },
              child: CText(
                'Share',
                color: white,
              )),
        ),
      ),
    );
  }

  void _validateFields() {
    if (_imageFile == null) {
      Get.snackbar("Error", "Please upload an image");
      return;
    }

    if (_titleController.text.isEmpty) {
      Get.snackbar("Error", "Title cannot be empty");
      return;
    }

    if (_descController.text.isEmpty) {
      Get.snackbar("Error", "Description cannot be empty");
      return;
    }
    final PostController postController = Get.put(PostController());
    postController.uploadData(
        _imageFile, _titleController.text.trim(), _descController.text.trim());
  }
}
