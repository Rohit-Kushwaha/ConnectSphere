class ChatRequestModel {
  final String? senderId;
  final String? receiverId;

  ChatRequestModel({
    this.senderId,
    this.receiverId,
  });

  ChatRequestModel.fromJson(Map<String, dynamic> json)
    : senderId = json['senderId'] as String?,
      receiverId = json['receiverId'] as String?;

  Map<String, dynamic> toJson() => {
    'senderId' : senderId,
    'receiverId' : receiverId
  };
}