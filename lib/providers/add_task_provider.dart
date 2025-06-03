import 'package:flutter/material.dart';

class AddTaskProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? deadline;

  void setDeadline(DateTime? value) {
    deadline = value;
    notifyListeners();
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    deadline = null;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
