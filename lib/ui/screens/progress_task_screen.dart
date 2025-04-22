import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/screens/task_screen.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      screenStatus: 'In Progress',
      apiLink: '', // Not needed for Firestore
    );
  }
}
