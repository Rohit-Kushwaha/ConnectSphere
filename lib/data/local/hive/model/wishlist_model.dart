import 'package:hive/hive.dart';

part 'wishlist_model.g.dart'; // Required for code generation

@HiveType(typeId: 0) // Define a unique typeId for this model
class WishlistModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? location;

  WishlistModel({this.id, this.title, this.location});
}
