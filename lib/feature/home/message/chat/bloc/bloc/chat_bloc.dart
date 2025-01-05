import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/message/chat/model/req/chat_req.dart';
import 'package:career_sphere/feature/home/message/chat/model/res/chat_res.dart';
import 'package:career_sphere/feature/home/message/chat/repo/chat_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  ChatBloc(this.chatRepo) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    on<GetChatMessage>((event, emit) async {
      emit(ChatLoadingState());
      try {
        debugPrint("Called");
        var charRequestData =
            ChatRequestModel(sender: event.sender, receiver: event.receiver);

        final ChatResponseModel chatResponseModel =
            await chatRepo.getMessage(chatRequestModel: charRequestData);
        emit(ChatSuccessState(chatResponseModel: chatResponseModel));
      } on ErrorResponseModel catch (error) {
        emit(ChatErrorState(error: error.message));
      } catch (e) {
        emit(ChatErrorState(error: "An unexpected error"));
      }
    });

    on<AddNewMessage>((event, emit) {
      if (state is ChatSuccessState) {
        final currentState = state as ChatSuccessState;

        final updatedMessages = List.of(currentState.chatResponseModel.messages)
          ..add(event.newMessage);

        debugPrint(event.newMessage.toString());

        emit(ChatSuccessState(
            chatResponseModel: ChatResponseModel(messages: updatedMessages)));
      }
    });
  }
}
