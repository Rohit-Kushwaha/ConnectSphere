class AddUserResponse {
  final String? msg;

  AddUserResponse({
    this.msg,
  });

  AddUserResponse.fromJson(Map<String, dynamic> json)
    : msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'msg' : msg
  };
}