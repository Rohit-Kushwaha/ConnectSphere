import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/message/msg/model/req/add_user_req.dart';
import 'package:career_sphere/feature/home/message/msg/model/req/chatted_req.dart';
import 'package:career_sphere/feature/home/message/msg/model/req/req.dart';
import 'package:career_sphere/feature/home/message/msg/model/res/add_user_response.dart';
import 'package:career_sphere/feature/home/message/msg/model/res/chatted_response.dart';
import 'package:career_sphere/feature/home/message/msg/model/res/res.dart';
import 'package:career_sphere/feature/home/message/msg/repo/message_repo.dart';
import 'package:career_sphere/utils/deboucing.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final _debouncer = Debouncer(second: 1);
  final MessageRepo messageRepo;
  MessageBloc(this.messageRepo) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});

// Debounce the search

    on<SearchUserEvent>((event, emit) async {
      // Use a Completer to handle async operations in the debouncer
      final completer = Completer<void>();
      _debouncer.run(() async {
        emit(SearchUserWaitState());

        // Check if the search query has at least 3 characters
        if (event.name.length < 3) {
          // If less than 3 characters, emit an empty or cleared state
          return emit(SearchEmptySuccessState(searchResponseModel: []));
        }
        try {
          var searchRequestModel = SearchRequestModel(name: event.name);

          final searchResponseModel = await messageRepo.searchUser(
              searchRequestModel: searchRequestModel);
          emit(SearchSuccessState(searchResponseModel: searchResponseModel));
        } on ErrorResponseModel catch (error) {
          emit(SearchErrorState(msg: error.message));
        } catch (e) {
          emit(SearchErrorState(msg: "An unexpected errror"));
        }
      });
      // Await the Completer to ensure the handler doesn't exit early
      await completer.future;
    });

    on<GetChattedListEvent>((event, emit) async {
      try {
        emit(GetChattedListSuccessLoading());

        var chattedUserRequest = ChatteUserRequest(senderId: event.senderId);
        final chatteUserList = await messageRepo.getAllChattedUser(
            chattedUserRequest: chattedUserRequest);
        emit(GetChattedListSuccessState(chatteUserResponse: chatteUserList));
      } on ErrorResponseModel catch (e) {
        emit(GetChattedListSuccessFailure(error: e.message));
      } catch (e) {
        emit(GetChattedListSuccessFailure(error: "An un expected error"));
      }
    });

    on<SaveUserChattingEvent>((event, emit) async {
      try {
        emit(ChatSaveWaitState());

        AddUserRequest addUserRequest = AddUserRequest(
            senderId: event.senderID, receiverId: event.receiverID);

        final saveChattedUser =
            await messageRepo.sendAddedUser(addUserRequest: addUserRequest);

        emit(ChatSaveState(saveChattedUser: saveChattedUser));
      } on ErrorResponseModel catch (e) {
        emit(ChatErrorState(error: e.message));
      } catch (e) {
        emit(ChatErrorState(error: "An unexpected error"));
      }
    });
  }
}
