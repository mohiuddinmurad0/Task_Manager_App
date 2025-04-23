import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/screens/task_screen.dart';

class CompleteTaskScreen extends StatelessWidget {
  const CompleteTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      screenStatus: 'Completed',
      apiLink: '', // Not needed for Firestore
    );
  }
}
