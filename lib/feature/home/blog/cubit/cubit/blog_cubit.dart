import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/blog/model/res/blog_response.dart';
import 'package:career_sphere/feature/home/blog/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogRepoImpl blogRepoImpl = BlogRepoImpl();
  BlogCubit() : super(BlogState());

  getBlogPlaces() async {
    try {
      final blogs = await blogRepoImpl.getBlogs();
      emit(state.copyWith(blogResponse: blogs));
    } on ErrorResponseModel catch (e) {
      emit(state.copyWith(error: e.message));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
