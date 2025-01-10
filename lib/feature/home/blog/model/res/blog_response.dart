class BlogResponse {
  String? id;
  UserId? userId;
  String? image;
  String? postTitle;
  String? username;
  String? createdAt;
  String? updatedAt;
  int? v;

  BlogResponse({
    this.id,
    this.userId,
    this.image,
    this.postTitle,
    this.username,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  BlogResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    userId = (json['user_id'] as Map<String,dynamic>?) != null ? UserId.fromJson(json['user_id'] as Map<String,dynamic>) : null;
    image = json['image'] as String?;
    postTitle = json['postTitle'] as String?;
    username = json['username'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    v = json['__v'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['user_id'] = userId?.toJson();
    json['image'] = image;
    json['postTitle'] = postTitle;
    json['username'] = username;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['__v'] = v;
    return json;
  }
}

class UserId {
  String? id;
  String? name;
  String? email;

  UserId({
    this.id,
    this.name,
    this.email,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    name = json['name'] as String?;
    email = json['email'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['name'] = name;
    json['email'] = email;
    return json;
  }
}