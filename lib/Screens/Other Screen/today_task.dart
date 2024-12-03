import 'package:flutter/material.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:habittracker/providers/task_provider.dart'; // Import TaskProvider
import 'package:provider/provider.dart';

import '../../Widgets/mainappbar.dart';
import '../../Widgets/task_container.dart';
import 'task_details_screen.dart';

class TodayTask extends StatefulWidget {
  static const String todayTaskRoute = "/todayTask";
  const TodayTask({super.key});

  @override
  State<TodayTask> createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {
  late HomeProvider homeProvider;
  late TaskProvider taskProvider;

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const MainAppBar(
        title: "Today Task",
        isBack: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 160,
              ),
              itemCount: homeProvider.todayList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final task = homeProvider.todayList[index];

                // Safely handle null values
                final taskId = task["_id"] ?? "noid"; // Add taskId
                final title = task["title"] ?? "No Title";
                final subtitle = task["subtitle"] ?? "No Description";
                final endDate = task["endDate"] ?? "No Due Date";
                bool isCompleted = task["status"]=="done";
                
                print("object task"+task.toString());

                return GestureDetector(
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(

                          taskId: taskId, // Pass taskId
                          title: title,
                          subtitle: subtitle,
                          endDate: endDate,
                          isCompleted: isCompleted,
                        ),
                      ),
                    );
                  },
                  child: taskContainer(
                    icon: task["icon"], // Ensure the "icon" key exists
                    subtitle: subtitle,
                    title: title,
                    context: context,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}