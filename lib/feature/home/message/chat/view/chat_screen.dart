import 'package:career_sphere/feature/home/message/chat/bloc/bloc/chat_bloc.dart';
import 'package:career_sphere/feature/home/message/chat/model/res/chat_res.dart';
import 'package:career_sphere/feature/home/message/chat/repo/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.receiverName,
    required this.senderName,
  });

  final String receiverName;
  final String senderName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// class _ChatScreenState extends State<ChatScreen> {
//   late Socket socket;
//   final TextEditingController messageController = TextEditingController();
//   List<Messages> messages = [];

//   @override
//   void initState() {
//     connectToServer();
//     super.initState();
//   }

//   void connectToServer() {
//     debugPrint("Connection start");
//     socket = io(
//       'https://ecommerce-lv31.onrender.com',
//       OptionBuilder().setTransports(['websocket']).build(),
//     );
//     debugPrint("Connection done");

//     socket.connect();

//     socket.on('receive_message', (data) {
//       debugPrint('Server response: ${data['receiver']},${widget.senderName}');
//       // if (data['receiver'] == widget.senderName) {
//       // Ensure message is intended for this user
//       setState(() {
//         messages.add(Messages(
//           message: messageController.text,
//         ));
//         // messages.add({
//         //   'sender': data['sender'],
//         //   'receiver': data['receiver'],
//         //   'message': data['message'],
//         // });
//       });
//       // }
//       //   final newMessage = Messages(
//       // // 'sender': data['sender'],
//       // // receiver: data['receiver'],
//       // message: data['message'],
//       // );
//       // context.read<ChatBloc>().add(AddNewMessage(newMessage: newMessage));
//     });
//   }

//   void sendMessage() {
//     if (messageController.text.isNotEmpty) {
//       socket.emit('send_message', {
//         'sender': widget.senderName,
//         'receiver': widget.receiverName, // Change for private/group chat
//         'message': messageController.text,
//       });
//       setState(() {
//         messages.add(Messages(
//           message: messageController.text,
//         ));
//         // messages.add({
//         //   'sender': widget.senderName,
//         //   'receiver': widget.receiverName, // Change for private/group chat
//         //   'message': messageController.text,
//         // });
//         messageController.clear();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ChatBloc(ChatRepoImpl())
//         ..add(GetChatMessage(
//             sender: widget.senderName, receiver: widget.receiverName)),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Chat"),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocConsumer<ChatBloc, ChatState>(
//                 listener: (context, state) {},
//                 builder: (context, state) {
//                   if (state is ChatSuccessState) {
//                     return ListView.builder(
//                       reverse: true,
//                       padding: EdgeInsets.symmetric(vertical: 10.h),
//                       itemCount: state.chatResponseModel.messages.length,
//                       itemBuilder: (context, index) {
//                         var l = state.chatResponseModel.messages.length;
//                         var chat =
//                             state.chatResponseModel.messages[l - 1 - index];

//                         return Align(
//                           alignment: widget.senderName == widget.senderName
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: widget.senderName == "Rohit"
//                                   ? Colors.blue
//                                   : Colors.grey.shade300,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               chat.message,
//                               style: TextStyle(
//                                 color: widget.senderName == "me"
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return SizedBox.shrink();
//                 },
//               ),
//             ),
//             Divider(height: 1.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10.w, bottom: 20.h),
//                       child: TextField(
//                         controller: messageController,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left: 10.w),
//                           hintText: "Type a message...",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 5.w),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20.h),
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.blue),
//                       onPressed: sendMessage,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _ChatScreenState extends State<ChatScreen> {
  late Socket socket;
  final TextEditingController messageController = TextEditingController();
  List<Messages> messageList = []; // Dedicated list for messages

  @override
  void initState() {
    connectToServer();
    super.initState();
  }

  void connectToServer() {
    socket = io(
      'https://ecommerce-lv31.onrender.com',
      OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.connect();

    socket.on('receive_message', (data) {
      if (data['receiver'] == widget.senderName) {
        setState(() {
          messageList.add(Messages(message: data['message']));
        });
      }
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      socket.emit('send_message', {
        'sender': widget.senderName,
        'receiver': widget.receiverName,
        'message': messageController.text,
      });
      setState(() {
        messageList.add(Messages(message: messageController.text));
        messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    socket.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(ChatRepoImpl())
        ..add(GetChatMessage(
            sender: widget.senderName, receiver: widget.receiverName)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccessState) {
                    setState(() {
                      messageList = state.chatResponseModel.messages;
                    });
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      var l = messageList.length;
                      var chat = messageList[l - 1 - index];
                      var message = messageList[index];
                      return Align(
                        alignment: widget.senderName == widget.senderName
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: widget.senderName == "Rohit"
                                ? Colors.blue
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            chat.message,
                            style: TextStyle(
                              color: widget.senderName == "Rohit"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: 1.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, bottom: 20.h),
                      child: TextField(
                        controller: messageController,
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
                      onPressed: sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
