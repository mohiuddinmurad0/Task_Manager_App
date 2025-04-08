// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';

class UpdateStatus extends StatefulWidget {
  final TaskData task;
  const UpdateStatus(
      {super.key, required this.task, required this.onTaskComplete});
  final VoidCallback onTaskComplete;

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;
  bool updateTaskInProgress = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller()
        .getRequest(ApiLinks.updateTask(taskId, newStatus));
    updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onTaskComplete();
      if (mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Status Update failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Update Status',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            )),
        Expanded(
          child: ListView(
            children: [
              for (int index = 0; index < taskStatusList.length; index++)
                RadioListTile<String>(
                  value: taskStatusList[index],
                  groupValue: _selectedTask,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTask = value!;
                    });
                  },
                  title: Text(taskStatusList[index].toUpperCase()),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Visibility(
              visible: !updateTaskInProgress,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: CustomButton(
                onPresse: () {
                  updateTask(widget.task.sId!, _selectedTask);
                },
              )),
        )
      ],
    );
  }
}
