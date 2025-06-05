import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/providers/add_task_provider.dart';
import 'package:todolist/providers/home_provider.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTaskProvider(),
      child: const _AddTaskForm(),
    );
  }
}

class _AddTaskForm extends StatelessWidget {
  const _AddTaskForm();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AddTaskProvider>(context);
    final homeProv = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Center(
            child: Container(
              constraints: isWide
                  ? const BoxConstraints(maxWidth: 480)
                  : const BoxConstraints(),
              margin: isWide
                  ? const EdgeInsets.symmetric(vertical: 32, horizontal: 24)
                  : EdgeInsets.zero,
              padding:
                  isWide ? const EdgeInsets.all(32) : const EdgeInsets.all(20),
              decoration: isWide
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    )
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: prov.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Judul',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: prov.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  const Text('Deadline',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: now,
                        lastDate: DateTime(now.year + 5),
                      );
                      if (picked != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          prov.setDeadline(DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            time.hour,
                            time.minute,
                          ));
                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.blue.shade400),
                          const SizedBox(width: 12),
                          Text(
                            prov.deadline != null
                                ? '${prov.deadline!.day.toString().padLeft(2, '0')}-${prov.deadline!.month.toString().padLeft(2, '0')}-${prov.deadline!.year}  ${prov.deadline!.hour.toString().padLeft(2, '0')}:${prov.deadline!.minute.toString().padLeft(2, '0')}'
                                : 'Pilih deadline',
                            style: TextStyle(
                              color: prov.deadline != null
                                  ? Colors.black87
                                  : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (prov.titleController.text.isNotEmpty &&
                            prov.descriptionController.text.isNotEmpty &&
                            prov.deadline != null) {
                          homeProv.addTaskWithData(
                            prov.titleController.text,
                            prov.descriptionController.text,
                            DateTime.now(),
                            prov.deadline!,
                          );
                          prov.clear();
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Semua field wajib diisi!')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_task_rounded, size: 24),
                          SizedBox(width: 10),
                          Text('Tambah Tugas'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
