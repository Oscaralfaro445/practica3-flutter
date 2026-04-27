import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 0)
class PhotoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String filePath;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String? description;

  PhotoModel({
    required this.id,
    required this.filePath,
    required this.createdAt,
    this.description,
  });
}
