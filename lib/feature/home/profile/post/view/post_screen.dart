import 'package:career_sphere/feature/home/profile/post/bloc/bloc/post_bloc.dart';
import 'package:career_sphere/feature/home/profile/post/cubit/cubit/upload_image_cubit.dart';
import 'package:career_sphere/feature/home/profile/post/cubit/cubit/upload_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              final bloc = context.read<PostBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => _showImageSourceBottomSheet(context, bloc),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: state.selectedImage == null
                          ? Center(
                              child: Text("Tap to select an image"),
                            )
                          : Image.file(
                              state.selectedImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    // controller: bloc.textController,
                    onChanged: (val) {
                      bloc.add(UpdatePostTextEvent(val));
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      labelText: 'Write something...',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (state.selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Image is missing")));
                      } 
                      // else if ( ) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Description is missing")));
                      // } 
                      else {
                        bloc.add(UploadPostEvent());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Post uploaded successfully!')),
                        );
                      }
                    },
                    child: Text('Upload Post'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showImageSourceBottomSheet(BuildContext context, PostBloc bloc) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                bloc.add(PickImageEvent(ImageSource.gallery));
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.of(context).pop();
                bloc.add(PickImageEvent(ImageSource.camera));
              },
            ),
          ],
        ),
      ),
    );
  }
}
