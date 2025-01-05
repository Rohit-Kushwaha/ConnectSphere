class ChatResponseModel {
  ChatResponseModel({
    required this.messages,
  });
  late final List<Messages> messages;

  ChatResponseModel.fromJson(Map<String, dynamic> json) {
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Messages {
  Messages({
    required this.message,
  });
  late final String message;

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    return _data;
  }
}
