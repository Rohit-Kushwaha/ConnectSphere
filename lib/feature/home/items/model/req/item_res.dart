class ItemsResponse {
  final String? status;
  final int? result;
  final List<Items>? items;

  ItemsResponse({
    this.status,
    this.result,
    this.items,
  });

  ItemsResponse.fromJson(Map<String, dynamic> json)
    : status = json['status'] as String?,
      result = json['result'] as int?,
      items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'result' : result,
    'items' : items?.map((e) => e.toJson()).toList()
  };
}

class Items {
  final String? id;
  final String? itemId;
  final String? name;
  final String? image;
  final String? description;
  final double? price;
  final String? currency;
  final double? rating;
  final String? category;
  final List<String>? tags;
  final String? url;
  final List<String>? features;
  final int? v;
  final String? createdAt;
  final String? updatedAt;

  Items({
    this.id,
    this.itemId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.currency,
    this.rating,
    this.category,
    this.tags,
    this.url,
    this.features,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  Items.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      itemId = json['item_id'] as String?,
      name = json['name'] as String?,
      image = json['image'] as String?,
      description = json['description'] as String?,
      price = json['price'] as double?,
      currency = json['currency'] as String?,
      rating = json['rating'] as double?,
      category = json['category'] as String?,
      tags = (json['tags'] as List?)?.map((dynamic e) => e as String).toList(),
      url = json['url'] as String?,
      features = (json['features'] as List?)?.map((dynamic e) => e as String).toList(),
      v = json['__v'] as int?,
      createdAt = json['createdAt'] as String?,
      updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'item_id' : itemId,
    'name' : name,
    'image' : image,
    'description' : description,
    'price' : price,
    'currency' : currency,
    'rating' : rating,
    'category' : category,
    'tags' : tags,
    'url' : url,
    'features' : features,
    '__v' : v,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}

// CopyWith method to clone and modify the object
  ItemsResponse copyWith({
    String? status,
    int? result,
    List<Items>? items,
    
  }) {
    return ItemsResponse(
      status: status ?? status,
      result: result ?? result,
      items: items ?? items,
     
    );
  }