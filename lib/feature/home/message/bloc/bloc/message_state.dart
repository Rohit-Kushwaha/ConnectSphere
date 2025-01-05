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