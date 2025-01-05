// A base class for both Login and VerifiedFalseResponse models
abstract class BaseLoginResponse {}

class LoginModel implements BaseLoginResponse {
  String? accessToken;

  LoginModel({this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['accessToken'] = accessToken;
    return json;
  }
}

class VerifiedFalseResponseModel implements BaseLoginResponse {
  final String? id;
  final String? name;
  final String? email;
  final bool? isVerified;

  VerifiedFalseResponseModel({
    this.id,
    this.name,
    this.email,
    this.isVerified,
  });

  VerifiedFalseResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        isVerified = json['isVerified'] as bool?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'isVerified': isVerified};
}
