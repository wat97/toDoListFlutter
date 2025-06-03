import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todolist/core/utils/hive_setup.dart';
import 'package:todolist/data/local/hive_task.dart';
import 'package:todolist/data/models/task_model.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Inisialisasi Hive
  await initHive();

  // Register box
  final taskBox = Hive.box<TaskModel>('tasksBox');
  sl.registerLazySingleton<Box<TaskModel>>(() => taskBox);

  // Register datasource
  sl.registerLazySingleton<HiveTaskDatasource>(
      () => HiveTaskDatasource(sl<Box<TaskModel>>()));
}
