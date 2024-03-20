// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/home/data/models/blog_model.dart';
import 'package:blog_app/features/home/data/models/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/home/data/models/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/home/domain/entities/blog.dart';
import 'package:blog_app/features/home/domain/repositories/blog_repo.dart';

class BlogRepositoryImple implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionCheck connectionCheck;
  BlogRepositoryImple({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionCheck,
  });
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String content,
    required String title,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionCheck.isConnected)) {
        return left(Failure("No internet connection"));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: "imageUrl",
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModel: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionCheck.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
