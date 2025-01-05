class PlaceResponseModel {
  PlaceResponseModel({
    required this.status,
    required this.result,
    required this.places,
  });
  late final String status;
  late final int result;
  late final List<Places> places;

  PlaceResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
    places = List.from(json['places']).map((e) => Places.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result;
    data['places'] = places.map((e) => e.toJson()).toList();
    return data;
  }
}

class Places {
  Places({
    required this.id,
    required this.placeId,
    required this.name,
    required this.location,
    required this.image,
    required this.category,
    required this.tags,
    required this.rating,
    required this.description,
    required this.V,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String placeId;
  late final String name;
  late final String location;
  late final String image;
  late final String category;
  late final List<String> tags;
  late final double rating;
  late final List<Description> description;
  late final int V;
  late final String createdAt;
  late final String updatedAt;

  Places.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    placeId = json['place_id'];
    name = json['name'];
    location = json['location'];
    image = json['image'];
    category = json['category'];
    tags = List.castFrom<dynamic, String>(json['tags']);
    rating = json['rating'];
    description = List.from(json['description'])
        .map((e) => Description.fromJson(e))
        .toList();
    V = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['place_id'] = placeId;
    data['name'] = name;
    data['location'] = location;
    data['image'] = image;
    data['category'] = category;
    data['tags'] = tags;
    data['rating'] = rating;
    data['description'] = description.map((e) => e.toJson()).toList();
    data['__v'] = V;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Description {
  Description({
    required this.summary,
    required this.price,
    required this.history,
    required this.bestTimeToVisit,
    required this.tips,
    required this.facilities,
    required this.id,
  });
  late final String summary;
  late final int price;
  late final String history;
  late final String bestTimeToVisit;
  late final String tips;
  late final List<String> facilities;
  late final String id;

  Description.fromJson(Map<String, dynamic> json) {
    summary = json['summary'];
    price = json['price'];
    history = json['history'];
    bestTimeToVisit = json['bestTimeToVisit'];
    tips = json['tips'];
    facilities = List.castFrom<dynamic, String>(json['facilities']);
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['summary'] = summary;
    data['price'] = price;
    data['history'] = history;
    data['bestTimeToVisit'] = bestTimeToVisit;
    data['tips'] = tips;
    data['facilities'] = facilities;
    data['_id'] = id;
    return data;
  }
}
