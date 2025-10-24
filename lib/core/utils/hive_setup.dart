import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:todolist/data/models/task_model.dart';
// Only import path_provider and hive_flutter if not web
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Hive.registerAdapter(TaskStatusAdapter());
  Hive.registerAdapter(TaskModelAdapter());

  await Hive.openBox<TaskModel>('tasksBox');
}
