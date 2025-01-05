part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessage extends ChatEvent {
  final String sender, receiver;

  const GetChatMessage({required this.sender, required this.receiver});

   @override
   List<Object> get props => [sender, receiver];
}

class AddNewMessage extends ChatEvent {
  final Messages newMessage; // Assuming `ChatMessage` is your message model

  const AddNewMessage({required this.newMessage});

  // @override
  // List<Object> get props => [newMessage];
}