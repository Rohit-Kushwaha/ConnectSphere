import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState()) {
    final ImagePicker picker = ImagePicker();

    on<PostEvent>((event, emit) {});

    on<PickImageEvent>((event, emit) async {
      final XFile? pickedFile = await picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(
          state.copyWith(
            selectedImage: File(pickedFile.path),
          ),
        );
      }
    });

    on<UpdatePostTextEvent>((event, emit) {
      emit(state.copyWith(postText: event.text));
    });

    on<UploadPostEvent>((event, emit) {
      // hit api
      debugPrint("A");
      debugPrint(state.selectedImage!.path.toString());
       final filePath = state.selectedImage!.path; // Full path of the image
    final fileName = path.basename(filePath);  // Extract only the file name));
       debugPrint('File Name: $fileName');        // Outputs: image_picker_xxxx.jpg
  debugPrint('Post Text: ${state.postText}');
      // emit(PostState());
    });
  }
}
