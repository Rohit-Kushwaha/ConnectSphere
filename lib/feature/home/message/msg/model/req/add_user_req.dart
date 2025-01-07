class AddUserRequest {
  final String? senderId;
  final String? receiverId;

  AddUserRequest({
    this.senderId,
    this.receiverId,
  });

  AddUserRequest.fromJson(Map<String, dynamic> json)
    : senderId = json['senderId'] as String?,
      receiverId = json['receiverId'] as String?;

  Map<String, dynamic> toJson() => {
    'senderId' : senderId,
    'receiverId' : receiverId
  };
}