import 'package:hive/hive.dart';
part 'task_model.g.dart'; // <-- ini penting!

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  todo,
  @HiveField(1)
  doing,
  @HiveField(2)
  done,
}

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime deadline;

  @HiveField(3)
  TaskStatus status;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  DateTime? deletedAt;

  TaskModel(
      {required this.title,
      required this.description,
      required this.deadline,
      this.status = TaskStatus.todo,
      DateTime? createdAt,
      DateTime? updatedAt,
      this.deletedAt})
      : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();
}
