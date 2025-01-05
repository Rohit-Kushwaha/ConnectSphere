class SearchResponseModel {
  SearchResponseModel({
    required this.users,
  });
  late final List<Users> users;
  
  SearchResponseModel.fromJson(Map<String, dynamic> json){
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['users'] = users.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Users {
  Users({
    required this.name,
  });
  late final String name;
  
  Users.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}