import 'package:flutter/material.dart';
import 'package:todolist/core/di/injection.dart';
import 'package:todolist/data/local/hive_task.dart';
import 'package:todolist/data/models/task_model.dart';

class HomeProvider with ChangeNotifier {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  set isInitialized(bool value) {
    _isInitialized = value;
    notifyListeners();
  }

  final HiveTaskDatasource _datasource = sl<HiveTaskDatasource>();

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  setUp(BuildContext context) {
    // Initialize any necessary data or services here
    // For example, you might want to set up a database connection or fetch

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Simulate a delay for initialization
      await Future.delayed(const Duration(seconds: 2));
      await loadTasks(); // Load tasks from the datasource
      isInitialized = true; // Set the initialization flag to true
    });
    notifyListeners();
  }

  Future<void> loadTasks() async {
    _tasks = _datasource.getActiveTasks();
    _tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _tasks.forEach((task) {
      print('Task: ${task.title}, Created At: ${task.createdAt}');
    });
    notifyListeners();
  }

  // add a new task
  Future<void> addTask() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final task = TaskModel(
      title: title,
      description: description,
      createdAt: DateTime.now(),
      status: TaskStatus.todo,
      deadline: DateTime.now()
          .add(const Duration(days: 7)), // Default deadline 7 days from now
    );
    await _datasource.addTask(task);
    titleController.clear();
    descriptionController.clear();
    notifyListeners(); // Notify listeners to update the UI
    await loadTasks(); // Reload tasks after adding a new one
  }

  // add a new task with custom data
  Future<void> addTaskWithData(String title, String description,
      DateTime createdAt, DateTime deadline) async {
    final task = TaskModel(
      title: title,
      description: description,
      createdAt: createdAt,
      status: TaskStatus.todo,
      deadline: deadline,
    );
    await _datasource.addTask(task);
    notifyListeners();
    await loadTasks();
  }

  // update status task menjadi done
  Future<void> markTaskDone(TaskModel task) async {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      task.status = TaskStatus.done;
      task.updatedAt = DateTime.now();
      await _datasource.updateTask(index, task);
      await loadTasks();
    }
  }
}
