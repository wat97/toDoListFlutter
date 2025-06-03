import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/add_task_provider.dart';
import 'package:todolist/ui/page/add_task_page.dart';

class RouteBase extends MaterialPageRoute {
  RouteBase({required super.builder});

  @override
  Duration get transitionDuration => const Duration(seconds: 0);
}

class RouteApp {
  MaterialPageRoute get routeAddTask {
    return RouteBase(
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (context) => AddTaskProvider(),
        builder: (context, child) => const AddTaskPage(),
      ),
    );
  }
}
