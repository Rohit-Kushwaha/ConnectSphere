// import 'dart:io';

// import 'package:career_sphere/feature/home/profile/post/cubit/cubit/upload_image_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class PostCubit extends Cubit<PostState> {
//   PostCubit() : super(PostState());

//   final TextEditingController textController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();

//   void pickImage(ImageSource source) async {
//     final XFile? pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       emit(
//         state.copyWith(
//           selectedImage: File(pickedFile.path),
//         ),
//       );
//     }
//   }

//   void updatePostText(String text) {
//     emit(state.copyWith(postText: text));
//   }

//   void uploadPost(BuildContext context) {
//     if (state.selectedImage == null && state.postText.isEmpty ||
//         state.postText == '') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please add an image or text before uploading.'),
//         ),
//       );
//       return;
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Post uploaded successfully!')),
//     );
//     debugPrint(textController.text.toString());
//     textController.clear();
//     // Reset state and text field
//     emit(PostState()); // Reset state after upload
//   }
// }
