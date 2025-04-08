import 'package:flutter/material.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/screens/update_profile.dart';
import 'package:task_manager_flutter/ui/widgets/custom_button.dart';
import 'package:task_manager_flutter/ui/widgets/custom_text_form_field.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/user_banners.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();
  bool _addNewTaskLoading = false;

  Future<void> addNewTask() async {
    _addNewTaskLoading = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _taskNameController.text.trim(),
      "description": _taskDescriptionController.text.trim(),
      "status": "New",
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(ApiLinks.createTask, requestBody);
    _addNewTaskLoading = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _taskNameController.clear();
      _taskDescriptionController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Task Added Successfully"),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Task Added Failed"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userBanner(context, onTapped: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      }),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
