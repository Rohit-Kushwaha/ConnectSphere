class ChatteUserRequest {
  final String? senderId;

  ChatteUserRequest({
    this.senderId,
  });

  ChatteUserRequest.fromJson(Map<String, dynamic> json)
    : senderId = json['senderId'] as String?;

  Map<String, dynamic> toJson() => {
    'senderId' : senderId
  };
}