part of 'post_bloc.dart';

class PostState extends Equatable {
  final File? selectedImage;
  final String? postText;

  const PostState({this.selectedImage, this.postText});

  PostState copyWith({File? selectedImage, String? postText}) {
    return PostState(
      selectedImage: selectedImage ?? this.selectedImage,
      postText: postText ?? this.postText,
    );
  }

  @override
  List<Object?> get props => [selectedImage, postText];
}
