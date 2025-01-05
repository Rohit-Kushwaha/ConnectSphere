class RegisterModel {
  RegisterModel({
    required this.msg,
  });
  late final String msg;
  
  RegisterModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    return data;
  }
}