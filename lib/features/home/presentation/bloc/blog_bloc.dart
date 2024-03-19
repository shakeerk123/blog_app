// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/home/domain/entities/blog.dart';
import 'package:blog_app/features/home/domain/usecases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/features/home/domain/usecases/uplaod_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadButtenPressedEvent>(blogUploadButtenPressedEvent);
    on<FetchAllBlogsFromSupasbaseEvent>(fetchAllBlogsFromSupasbaseEvent);
  }

  FutureOr<void> blogUploadButtenPressedEvent(
      BlogUploadButtenPressedEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParam(
      event.posterId,
      event.title,
      event.content,
      event.image,
      event.topics,
    ));

    result.fold(
        (l) => emit(BlogFailure(l.messgae)), (r) => emit(BlogUploadSuccess()));
  }

  FutureOr<void> fetchAllBlogsFromSupasbaseEvent(
      FetchAllBlogsFromSupasbaseEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());
    res.fold(
        (l) => emit(BlogFailure(l.messgae)), (r) => emit(BlogDisplaySuccess(r)));
  }
}
