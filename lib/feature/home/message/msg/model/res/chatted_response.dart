class ChatteUserResponse {
  final List<Username>? username;

  ChatteUserResponse({
    this.username,
  });

  ChatteUserResponse.fromJson(Map<String, dynamic> json)
    : username = (json['username'] as List?)?.map((dynamic e) => Username.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'username' : username?.map((e) => e.toJson()).toList()
  };
}

class Username {
  final String? id;
  final String? name;

  Username({
    this.id,
    this.name,
  });

  Username.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'name' : name
  };
}