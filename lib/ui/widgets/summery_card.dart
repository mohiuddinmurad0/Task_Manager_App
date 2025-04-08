// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {
  final int numberOfTasks;
  final String title;
  const SummeryCard({
    Key? key,
    required this.numberOfTasks,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              "$numberOfTasks",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
