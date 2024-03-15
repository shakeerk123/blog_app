import 'dart:io';
import 'package:blog_app/core/consts/colors.dart';
import 'package:blog_app/core/utils/pick_images.dart';
import 'package:blog_app/features/home/presentation/widgets/custom_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  List<String> selectedCategory = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(image!, fit: BoxFit.cover))),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          color: AppColor.kBackGroundColor,
                          dashPattern: const [10, 4],
                          child: const SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Select your image")
                              ],
                            ),
                          )),
                    ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    "Programming",
                    "Bussiness",
                    "Quote",
                    "Sports",
                    "Entertainment"
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedCategory.contains(e)) {
                                  selectedCategory.remove(e);
                                } else {
                                  selectedCategory.add(e);
                                }

                                setState(() {});
                              },
                              child: Chip(
                                color: selectedCategory.contains(e)
                                    ? const MaterialStatePropertyAll(
                                        AppColor.kOrange)
                                    : null,
                                label: Text(e),
                                side: BorderSide(
                                    color: AppColor.kBackGroundColor),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              CustomTextForm(
                controller: titleController,
                hintText: 'Blog title',
              ),
              CustomTextForm(
                controller: descController,
                hintText: 'Blog Content',
              )
            ],
          ),
        ),
      ),
    );
  }
}
