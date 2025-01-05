class OtpRequestModel {
  final String email;

  OtpRequestModel({required this.email});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
