import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/home/domain/entities/blog.dart';
import 'package:blog_app/features/home/domain/repositories/blog_repo.dart';
import 'package:fpdart/fpdart.dart';


class UploadBlog implements UseCase<Blog, UploadBlogParam> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParam param) async {
    return await blogRepository.uploadBlog(
        image: param.image,
        content: param.content,
        title: param.title,
        posterId: param.posterId,
        topics: param.topics);
  }
}

class UploadBlogParam {

  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;
 

  UploadBlogParam( this.posterId, this.title, this.content, this.image,
      this.topics, );
}
