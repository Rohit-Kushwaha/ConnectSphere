import 'package:bloc/bloc.dart';
import 'package:career_sphere/common/response/error_response.dart';
import 'package:career_sphere/feature/home/message/chat/model/req/chat_req.dart';
import 'package:career_sphere/feature/home/message/chat/model/res/chat_res.dart';
import 'package:career_sphere/feature/home/message/chat/repo/chat_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  late Socket socket;
  final TextEditingController messageController = TextEditingController();
  ChatBloc(this.chatRepo) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<InitializeSocketEvent>((event, emit) {
      _initializeSocket();
    });

    on<GetChatMessage>((event, emit) async {
      emit(ChatLoadingState());
      try {
        var charRequestData = ChatRequestModel(
            senderId: event.sender, receiverId: event.receiver);

        final ChatResponseModel chatResponseModel =
            await chatRepo.getMessage(chatRequestModel: charRequestData);
        emit(ChatSuccessState(chatResponseModel: chatResponseModel));
      } on ErrorResponseModel catch (error) {
        emit(ChatErrorState(error: error.message));
      } catch (e) {
        emit(ChatErrorState(error: "An unexpected error"));
      }
    });

    on<ReceiveMessageEvent>((event, emit) {
      if (state is ChatSuccessState) {
        final currentState = state as ChatSuccessState;
        final updatedMessages =
            List.of(currentState.chatResponseModel.messages!)
              ..add(event.newMessage);

        emit(ChatSuccessState(
            chatResponseModel: ChatResponseModel(messages: updatedMessages)));
      }
    });

    on<SendMessageEvent>((event, emit) {
      if (messageController.text.isNotEmpty) {
        socket.emit('send_message', {
          'senderId': event.sender,
          'receiverId': event.receiver,
          'message': messageController.text,
        });

        messageController.clear();
      }
    });
  }

  void _initializeSocket() {
    socket = io(
      'https://ecommerce-lv31.onrender.com',
      // 'http://localhost:3000',

      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    socket.on('receive_message', (data) {
      final newMessage = Messages(
          message: data['message'],
          senderId: data['senderId'],
          receiverId: data['receiverId']);
      debugPrint("Received Event$data");
      add(ReceiveMessageEvent(newMessage: newMessage));
    });
  }

  @override
  Future<void> close() {
    socket.dispose();
    messageController.dispose();
    return super.close();
  }
}
