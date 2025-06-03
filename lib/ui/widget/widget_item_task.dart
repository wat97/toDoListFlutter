import 'package:flutter/material.dart';
import 'package:todolist/config/constants/app_theme.dart';

class WidgetItemTask extends StatelessWidget {
  const WidgetItemTask({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.deadline,
    this.isTaskDone = false,
    this.onDoneTap,
  });
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadline;
  final bool isTaskDone;
  final VoidCallback? onDoneTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isDone = now.isAfter(deadline);
    final isSameDay = now.year == deadline.year &&
        now.month == deadline.month &&
        now.day == deadline.day;
    final diff = deadline.difference(now);
    Color tileColor;
    if (isDone) {
      tileColor = Colors.green.shade200;
    } else if (diff.inHours < 2 && diff.inMinutes > 0) {
      tileColor = Colors.red.shade200;
    } else if (isSameDay) {
      tileColor = Colors.yellow.shade200;
    } else {
      tileColor = Colors.blue.shade200;
    }
    String deadlineStr =
        '${deadline.day.toString().padLeft(2, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.year} - '
        '${deadline.hour.toString().padLeft(2, '0')}:${deadline.minute.toString().padLeft(2, '0')}';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      color: tileColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: GestureDetector(
            onTap: isTaskDone ? null : onDoneTap,
            child: Icon(
              isTaskDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isTaskDone ? Colors.green : Colors.grey,
              size: 28,
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.taskTitle,
          ),
          subtitle: Text(
            'Deadline: $deadlineStr',
            style: AppTextStyles.taskSubtitle,
          ),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deskripsi: $description',
                      style: AppTextStyles.taskSubtitle),
                  const SizedBox(height: 8),
                  Text('Dibuat: ${createdAt.toLocal()}',
                      style: AppTextStyles.taskSubtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
