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

