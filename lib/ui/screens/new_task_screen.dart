import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/widgets/task_list_widget.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TaskListWidget(
      status: 'New',
      title: 'New Tasks',
    );
  }
}
