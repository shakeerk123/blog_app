import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/consts/colors.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/home/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/home/presentation/pages/add_new_blog.dart';
import 'package:blog_app/features/home/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (ctx) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchAllBlogsFromSupasbaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
        title: const Text("Blogify"),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const LoadingAnimation();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                      blog: blog,
                      color: index % 3 == 1
                          ? AppColor.kPrimary
                          : index % 3 == 2
                              ? AppColor.kOrange
                              : AppColor.kRed);
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
