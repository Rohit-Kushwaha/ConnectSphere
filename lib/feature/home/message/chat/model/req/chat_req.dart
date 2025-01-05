class ChatRequestModel {
  ChatRequestModel({
    required this.sender,
    required this.receiver,
  });
  late final String sender;
  late final String receiver;
  
  ChatRequestModel.fromJson(Map<String, dynamic> json){
    sender = json['sender'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender;
    _data['receiver'] = receiver;
    return _data;
  }
}