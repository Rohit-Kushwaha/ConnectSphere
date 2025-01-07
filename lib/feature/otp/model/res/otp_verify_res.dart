class OtpVerifyResponseModel {
  OtpVerifyResponseModel({required this.accessToken, required this.id});
  late final String accessToken;
  String? id;

  OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['id'] = id;
    return data;
  }
}
