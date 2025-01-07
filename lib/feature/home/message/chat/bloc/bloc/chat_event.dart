part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// Initialize the socket connection
class InitializeSocketEvent extends ChatEvent {}

class GetChatMessage extends ChatEvent {
  final String sender, receiver;

  const GetChatMessage({required this.sender, required this.receiver});

   @override
   List<Object> get props => [sender, receiver];
}

// Handle receiving a new message
class ReceiveMessageEvent extends ChatEvent {
  final Messages newMessage;

  const ReceiveMessageEvent({required this.newMessage});

  @override
  List<Object> get props => [newMessage];
}

// Handle sending a message
class SendMessageEvent extends ChatEvent {
  final String sender;
  final String receiver;

  const SendMessageEvent({required this.sender, required this.receiver});

  @override
  List<Object> get props => [sender, receiver];
}

class AddNewMessage extends ChatEvent {
  final List<Messages> newMessage; // Assuming `ChatMessage` is your message model

  const AddNewMessage({required this.newMessage});

  @override
  List<Object> get props => [newMessage];
}