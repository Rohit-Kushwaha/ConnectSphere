class ErrorResponseModel {
  final String message;

  ErrorResponseModel({required this.message});

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      message: json['msg'] ?? 'An unknown error occurred',
    );
  }
}
