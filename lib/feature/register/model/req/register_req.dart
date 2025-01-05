class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final bool isVerified;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.isVerified
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "isVerified" : isVerified
    };
  }
}
