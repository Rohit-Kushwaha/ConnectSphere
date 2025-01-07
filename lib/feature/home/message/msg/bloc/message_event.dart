part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class SearchUserEvent extends MessageEvent {
  final String name;

  const SearchUserEvent({required this.name});
}

class GetChattedListEvent extends MessageEvent {
  final String senderId;
  const GetChattedListEvent({required this.senderId});
}

class SaveUserChattingEvent extends MessageEvent {
  final String senderID, receiverID;
  const SaveUserChattingEvent(
      {required this.senderID, required this.receiverID});
}
