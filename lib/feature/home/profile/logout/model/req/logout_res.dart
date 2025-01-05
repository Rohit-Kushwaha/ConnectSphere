class LogoutRequest {
  final String? email;
  final String? password;

  LogoutRequest({
    this.email,
    this.password,
  });

  LogoutRequest.fromJson(Map<String, dynamic> json)
    : email = json['email'] as String?,
      password = json['password'] as String?;

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password
  };
}