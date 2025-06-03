import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/home_provider.dart';
import 'package:todolist/routes/routes_app.dart';
import 'package:todolist/ui/widget/widget_animated_tab_icon.dart';
import 'package:todolist/ui/widget/widget_item_task.dart';
import 'package:todolist/ui/page/add_task_page.dart'; // Import AddTaskPage
import 'package:todolist/data/models/task_model.dart';
import 'package:todolist/config/constants/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // You can call any setup methods here, such as initializing providers or fetching data
    // For example, if you have a provider, you might call:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).setUp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HomeProvider>(context);

    return Scaffold(
        // appBar: Utils.appBarCustomTransparent,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Modern header for To Do List
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.check_circle_outline,
                          size: 36, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To Do List',
                          style: AppTextStyles.header,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Kelola tugas harianmu dengan mudah',
                          style: AppTextStyles.subtitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              prov.isInitialized
                  ? contentBody(prov)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ));
  }

  Widget contentBody(HomeProvider prov) {
    return Expanded(
      child: Column(
        children: [
          // Add your content widgets here

          tabBarView(prov),

          // You can add more widgets as needed

          Expanded(
            child: PageView(
              controller: prov.pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => prov.setIndex(value),
              children: [
                // Page 1: Belum
                belumPage(prov),
                // Page 2: Selesai
                selesaiPage(prov),
              ],
            ),
          ),

          // Add a button to add a new task
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_task_rounded,
                    size: 24, color: Colors.white),
                label: const Text(
                  'Tambah Tugas',
                  style: AppTextStyles.button,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    RouteApp().routeAddTask,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBarView(HomeProvider prov) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedTabIcon(
              icon: Icons.folder_open,
              label: 'Belum',
              isSelected: prov.currentIndex == 0,
              onTap: () {
                prov.setIndex(0);
                prov.pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutExpo);
              },
            ),
          ),
          Expanded(
            child: AnimatedTabIcon(
              icon: Icons.star,
              label: 'Selesai',
              isSelected: prov.currentIndex == 1,
              onTap: () {
                prov.setIndex(1);
                prov.pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutExpo);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView belumPage(HomeProvider prov) {
    final belumTasks = prov.tasks
        .where((task) =>
            task.status == TaskStatus.todo || task.status == TaskStatus.doing)
        .toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: belumTasks.length,
      itemBuilder: (context, index) {
        final task = belumTasks[index];
        return WidgetItemTask(
          title: task.title,
          description: task.description,
          createdAt: task.createdAt,
          deadline: task.deadline,
          isTaskDone: task.status == TaskStatus.done,
          onDoneTap: task.status == TaskStatus.done
              ? null
              : () => prov.markTaskDone(task),
        );
      },
    );
  }

  ListView selesaiPage(HomeProvider prov) {
    final selesaiTasks =
        prov.tasks.where((task) => task.status == TaskStatus.done).toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: selesaiTasks.length,
      itemBuilder: (context, index) {
        final task = selesaiTasks[index];
        return WidgetItemTask(
          title: task.title,
          description: task.description,
          createdAt: task.createdAt,
          deadline: task.deadline,
          isTaskDone: true,
          onDoneTap: null,
        );
      },
    );
  }
}
