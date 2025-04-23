import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/screens/task_screen.dart';

class CancelledTaskScreen extends StatelessWidget {
  const CancelledTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScreen(
      screenStatus: "Cancelled",
      apiLink: '', // Not needed for Firestore
    );
  }
}
