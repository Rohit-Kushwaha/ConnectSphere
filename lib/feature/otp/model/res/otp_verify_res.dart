class OtpVerifyResponseModel {
  OtpVerifyResponseModel({
    required this.accessToken,
  });
  late final String accessToken;

  OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    return data;
  }
}
