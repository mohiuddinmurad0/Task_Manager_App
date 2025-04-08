import 'package:flutter/material.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/screens/task_screen.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      screenStatus: "New",
      apiLink: ApiLinks.newTaskStatus,
      showAllSummeryCard: true,
    );
  }
}
