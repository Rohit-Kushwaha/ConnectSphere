class LoginRequestModel {
  final String? email;
  final String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json)
    : email = json['email'] as String?,
      password = json['password'] as String?;

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password
  };
}