import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/widgets/task_list_widget.dart';

class CompleteTaskScreen extends StatelessWidget {
  const CompleteTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskListWidget(
      status: 'Completed',
      title: 'Completed Tasks',
    );
  }
}
