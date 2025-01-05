class SearchRequestModel {
  SearchRequestModel({
    required this.name,
  });
  late final String name;
  
  SearchRequestModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}