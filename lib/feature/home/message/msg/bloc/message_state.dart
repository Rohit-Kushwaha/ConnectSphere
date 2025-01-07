part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

class SearchUserWaitState extends MessageState {}

class SearchErrorState extends MessageState {
  final String msg;
  const SearchErrorState({required this.msg});
}

class SearchSuccessState extends MessageState {
  final SearchResponseModel searchResponseModel;

  const SearchSuccessState({required this.searchResponseModel});
}

class SearchEmptySuccessState extends MessageState {
  final List<SearchResponseModel> searchResponseModel;

  const SearchEmptySuccessState({required this.searchResponseModel});
}

class GetChattedListSuccessState extends MessageState {
  final ChatteUserResponse chatteUserResponse;
  const GetChattedListSuccessState({required this.chatteUserResponse});
}

class GetChattedListSuccessFailure extends MessageState {
  final String error;
  const GetChattedListSuccessFailure({required this.error});
}

class GetChattedListSuccessLoading extends MessageState {}

class ChatSaveWaitState extends MessageState {}

class ChatSaveState extends MessageState {
  final AddUserResponse saveChattedUser;
  const ChatSaveState({required this.saveChattedUser});
}

class ChatErrorState extends MessageState {
  final String error;
  const ChatErrorState({required this.error});
}
