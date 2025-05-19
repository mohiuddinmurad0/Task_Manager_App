import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/widgets/task_list_widget.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskListWidget(
      status: 'In Progress',
      title: 'In Progress Tasks',
    );
  }
}
