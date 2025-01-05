class OtpResponseModel {
  OtpResponseModel({
    required this.otp,
  });
  late final String otp;

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    otp = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = otp;
    return data;
  }
}
