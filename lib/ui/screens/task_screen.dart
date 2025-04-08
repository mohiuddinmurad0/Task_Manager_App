// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_manager_flutter/data/models/network_response.dart';
import 'package:task_manager_flutter/data/models/summery_count_model.dart';
import 'package:task_manager_flutter/data/models/task_model.dart';
import 'package:task_manager_flutter/data/services/network_caller.dart';
import 'package:task_manager_flutter/data/utils/api_links.dart';
import 'package:task_manager_flutter/ui/screens/add_task_screen.dart';
import 'package:task_manager_flutter/ui/screens/update_profile.dart';
import 'package:task_manager_flutter/ui/widgets/screen_background.dart';
import 'package:task_manager_flutter/ui/widgets/status_change_botom_sheet.dart';
import 'package:task_manager_flutter/ui/widgets/summery_card.dart';
import 'package:task_manager_flutter/ui/widgets/task_card.dart';
import 'package:task_manager_flutter/ui/widgets/user_banners.dart';

class TaskScreen extends StatefulWidget {
  final String screenStatus;
  final String apiLink;
  final bool showAllSummeryCard;
  final bool floatingActionButton;

  const TaskScreen({
    Key? key,
    required this.screenStatus,
    required this.apiLink,
    this.showAllSummeryCard = false,
    this.floatingActionButton = true,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTask();
      statusCount();
    });
  }

  TaskListModel _taskModel = TaskListModel();
  bool isLoading = false;

  Future<void> getTask() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(widget.apiLink);
    if (response.isSuccess) {
      _taskModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load data!"),
          ),
        );
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  StatusCountModel statusCountModel = StatusCountModel();
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;

  Future<void> statusCount() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse newTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.newTaskStatus);
    TaskListModel newTaskModel = TaskListModel.fromJson(newTaskResponse.body!);

    if (mounted) {
      setState(() {
        count1 = newTaskModel.data?.length ?? 0;
      });
    }

    final cancelledTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.cancelledTaskStatus);
    TaskListModel cancelledTaskModel =
        TaskListModel.fromJson(cancelledTaskResponse.body!);
    if (mounted) {
      setState(() {
        count2 = cancelledTaskModel.data?.length ?? 0;
      });
    }

    final completedTaskResponse =
        await NetworkCaller().getRequest(ApiLinks.completedTaskStatus);

    TaskListModel completedTaskModel =
        TaskListModel.fromJson(completedTaskResponse.body!);
    if (mounted) {
      setState(() {
        count3 = completedTaskModel.data?.length ?? 0;
      });
    }

    final inProgressResponse =
        await NetworkCaller().getRequest(ApiLinks.inProgressTaskStatus);
    TaskListModel inProgressTaskModel =
        TaskListModel.fromJson(inProgressResponse.body!);
    if (mounted) {
      setState(() {
        count4 = inProgressTaskModel.data?.length ?? 0;
      });
    }

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(ApiLinks.deleteTask(taskId));
    if (response.isSuccess) {
      _taskModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Task Deleted Successfully!")));
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // int getCountForStatus(String status) {
  //   final Data? statusData = statusCountModel.data?.firstWhere(
  //     (data) => data.statusId == status,
  //     orElse: () => Data(statusId: status, count: 0),
  //   );
  //   return statusData?.count ?? 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userBanner(
        context,
        onTapped: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UpdateProfileScreen()));
        },
      ),
      body: ScreenBackground(
        child: Column(
          children: [
            if (widget.showAllSummeryCard)
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Visibility(
                    visible: isLoading == false,
                    replacement: const Center(
                      child: LinearProgressIndicator(),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SummeryCard(
                            numberOfTasks: count1,
                            title: "New",
                          ),
                        ),
                        Expanded(
                          child: SummeryCard(
                            numberOfTasks: count3,
                            title: "Completed",
                          ),
                        ),
                        Expanded(
                          child: SummeryCard(
                            numberOfTasks: count2,
                            title: "Cancelled",
                          ),
                        ),
                        Expanded(
                          child: SummeryCard(
                            numberOfTasks: count4,
                            title: "Progress",
                          ),
                        ),
                      ],
                    ),
                  )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: RefreshIndicator(
                    onRefresh: () async {
                      getTask();
                      statusCount();
                    },
                    child: Visibility(
                      visible: isLoading == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ListView.builder(
                          itemCount: _taskModel.data?.length ?? 0,
                          itemBuilder: (context, int index) {
                            return CustomTaskCard(
                                title:
                                    _taskModel.data![index].title ?? "Unknown",
                                description:
                                    _taskModel.data![index].description ?? "",
                                createdDate:
                                    _taskModel.data![index].createdDate ?? "",
                                status: _taskModel.data![index].status ?? "NEW",
                                chipColor: _getChipColor(),
                                onChangeStatusPressed: () {
                                  statusUpdateButtomSheet(
                                      _taskModel.data![index]);
                                },
                                onEditPressed: () {},
                                onDeletePressed: () {
                                  deleteTask(_taskModel.data![index].sId!);
                                });
                          }),
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: widget.floatingActionButton == true,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Color _getChipColor() {
    switch (widget.screenStatus) {
      case "New":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "In Progress":
        return Colors.pink.shade400;
      default:
        return Colors.grey;
    }
  }

  void statusUpdateButtomSheet(TaskData task) {
    showModalBottomSheet(
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black)),
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black)),
          1)!,
      context: context,
      builder: (context) {
        return UpdateStatus(
          task: task,
          onTaskComplete: () {
            getTask();
          },
        );
      },
    );
  }
}
