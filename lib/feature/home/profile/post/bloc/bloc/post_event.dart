part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PickImageEvent extends PostEvent {
  final ImageSource source;
  const PickImageEvent(this.source);
}

class UpdatePostTextEvent extends PostEvent {
  final String text;
  const UpdatePostTextEvent(this.text);
}

class UploadPostEvent extends PostEvent {}
