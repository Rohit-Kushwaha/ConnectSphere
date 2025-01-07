import 'package:career_sphere/feature/home/message/chat/bloc/bloc/chat_bloc.dart';
import 'package:career_sphere/feature/home/message/chat/repo/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.receiverID,
    required this.senderID,
  });

  final String receiverID;
  final String senderID;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Socket socket;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(ChatRepoImpl())
        ..add(InitializeSocketEvent())
        ..add(GetChatMessage(
            sender: widget.senderID, receiver: widget.receiverID)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatSuccessState) {
                    final messages = state.chatResponseModel.messages;
                    return ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemCount: messages!.length,
                      itemBuilder: (context, index) {
                        final message = messages[messages.length - 1 - index];
                        final isSender = message.senderId == widget.senderID;
                        debugPrint("${message.senderId}SenderID");
                        // bool isSender;

                        return Align(
                            alignment: isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSender
                                      ? Colors.blue.shade400
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  message.message.toString(),
                                  style: TextStyle(
                                    color:
                                        isSender ? Colors.black : Colors.black,
                                  ),
                                )));
                        //   ),
                        // );
                      },
                    );
                  } else if (state is ChatErrorState) {
                    return Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            Divider(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Builder(builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, bottom: 20.h),
                        child: TextField(
                          // onChanged: (value){

                          // },
                          controller:
                              context.read<ChatBloc>().messageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10.w),
                            hintText: "Type a message...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                          context.read<ChatBloc>().add(SendMessageEvent(
                                sender: widget.senderID,
                                receiver: widget.receiverID,
                              ));
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void connectToServer() {
    socket = io(
      'http://localhost:3000',
      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    // socket.emit('join', 'YourUsername');

    socket.connect();

    socket.on('receive_message', (data) {
      // final newMessage = Messages(message: data['message']);
      debugPrint("Received Event");
      // add(ReceiveMessageEvent(newMessage: newMessage));
    });
  }
}
