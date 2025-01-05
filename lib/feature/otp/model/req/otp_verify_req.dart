class VerifyOtpRequestModel  {
  VerifyOtpRequestModel ({
    required this.email,
    required this.otp,
  });
  late final String email;
  late final String otp;
  
  VerifyOtpRequestModel .fromJson(Map<String, dynamic> json){
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}