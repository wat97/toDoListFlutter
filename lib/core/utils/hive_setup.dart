import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/data/models/task_model.dart';

Future<void> initHive() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(TaskStatusAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox<TaskModel>('tasksBox');
}
