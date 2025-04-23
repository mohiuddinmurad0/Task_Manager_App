import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController = TextEditingController();
  bool _addNewTaskLoading = false;

  Future<void> addNewTask() async {
    _addNewTaskLoading = true;
    if (mounted) {
      setState(() {});
    }

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("User not logged in");
      }

      final newTask = {
        "title": _taskNameController.text.trim(),
        "description": _taskDescriptionController.text.trim(),
        "status": "New",
        "createdDate": DateTime.now().toIso8601String(),
      };

      await FirebaseFirestore.instance.collection('users').doc(userId).collection('tasks').add(newTask);

      _taskNameController.clear();
      _taskDescriptionController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task Added Successfully")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add task: ${e.toString()}")),
        );
      }
    } finally {
      _addNewTaskLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Add Task",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      hintText: "Task Title",
                      controller: _taskNameController,
                      textInputType: TextInputType.text,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return "Please enter task title";
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      maxLines: 4,
                      hintText: "Description",
                      controller: _taskDescriptionController,
                      textInputType: TextInputType.text,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return "Please enter task description";
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                        visible: _addNewTaskLoading == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: CustomButton(
                          onPresse: () {
                            addNewTask();
                          },
                        )),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
