import 'package:hive/hive.dart';
import 'package:todolist/data/models/task_model.dart';

class HiveTaskDatasource {
  final Box<TaskModel> _box;

  HiveTaskDatasource(this._box);

  Future<void> addTask(TaskModel task) async {
    await _box.add(task);
  }

  List<TaskModel> getAllTasks() => _box.values.toList();

  Future<void> updateTask(int index, TaskModel task) async {
    await _box.putAt(index, task);
  }

  Future<void> deleteTask(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clearTasks() async {
    await _box.clear();
  }

  List<TaskModel> getActiveTasks() {
    return _box.values.where((task) => task.deletedAt == null).toList();
  }
}
