part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}
final class ChatLoadingState extends ChatState {}
final class ChatSuccessState extends ChatState {
  final ChatResponseModel chatResponseModel;
  

 const ChatSuccessState({required this.chatResponseModel});
  @override
  List<Object> get props => [chatResponseModel];
}

final class ChatErrorState extends ChatState {
  final String error;
  const ChatErrorState({required this.error});
    @override
  List<Object> get props => [error];
}

