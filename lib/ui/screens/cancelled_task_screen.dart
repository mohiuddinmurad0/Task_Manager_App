import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/widgets/task_list_widget.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskListWidget(
      status: 'Cancelled',
      title: 'Cancelled Tasks',
    );
  }
}
