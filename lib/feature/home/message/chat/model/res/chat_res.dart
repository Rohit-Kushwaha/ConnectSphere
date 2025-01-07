class ChatResponseModel {
  final List<Messages>? messages;

  ChatResponseModel({
    this.messages,
  });

  ChatResponseModel.fromJson(Map<String, dynamic> json)
      : messages = (json['messages'] as List?)
            ?.map((dynamic e) => Messages.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'messages': messages?.map((e) => e.toJson()).toList()};
}

class Messages {
  final String? message;
  final String? senderId;
  final String? receiverId;

  Messages({this.message, this.receiverId, this.senderId});

  Messages.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        senderId = json['senderId'] as String?,
        receiverId = json['receiverId'] as String?;

  Map<String, dynamic> toJson() => {
        'message': message,
        'senderId': senderId,
        'receiverId': receiverId,
      };
}
