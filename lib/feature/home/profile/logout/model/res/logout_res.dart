class LogoutResponse {
  final String? msg;

  LogoutResponse({
    this.msg,
  });

  LogoutResponse.fromJson(Map<String, dynamic> json)
    : msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'msg' : msg
  };
}