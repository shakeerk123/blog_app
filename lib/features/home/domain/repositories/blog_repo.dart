import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/home/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String content,
    required String title,
    required String posterId,
    required List<String> topics,
  });
}
