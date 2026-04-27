import 'package:hive/hive.dart';

part 'recording_model.g.dart';

@HiveType(typeId: 1)
class RecordingModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String filePath;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final int durationSeconds;

  @HiveField(4)
  final String? title;

  RecordingModel({
    required this.id,
    required this.filePath,
    required this.createdAt,
    required this.durationSeconds,
    this.title,
  });
}
