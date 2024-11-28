import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/task_provider.dart';
import 'package:provider/provider.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/mainappbar.dart';

class CreateHabit extends StatefulWidget {
  static const String createHabitRoute = "/createHabit";
  const CreateHabit({super.key});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  int selectedIconIndex = -1;

  Future<void> pickTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dateTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      controller.text = dateTime.toIso8601String();
    }
  }

  void createHabit(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    if (taskProvider.taskTitle.text.isEmpty || selectedIconIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide all required details")),
      );
      return;
    }

    taskProvider.createTask(context).then((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            backgroundColor: AppColors.containerColor,
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
              padding: const EdgeInsets.all(19),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.containerColor,
              ),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffE6F8EE),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/success.svg",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  sizeHeight(height: 28, context: context),
                  Text(
                    "Habit added successfully",
                    style: TextStyles.heading1,
                    textAlign: TextAlign.center,
                  ),
                  sizeHeight(height: 13, context: context),
                  Text(
                    "You have successfully created a new habit. Go to Home to continue your journey.",
                    style: TextStyles.subTitle,
                    textAlign: TextAlign.center,
                  ),
                  sizeHeight(height: 28, context: context),
                  mainButton(
                    title: "Go to Home",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home', // Replace with your home screen route.
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create habit: $e")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: mainButton(
                title: "Create",
                onTap: () => createHabit(context),
              ),
            ),
          ],
        ),
      ),
      appBar: const MainAppBar(
        title: "Create custom habit",
        isBack: true,
      ),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              mainTextField(
                hintText: "Name of habit",
                controller: taskProvider.taskTitle,
              ),
              sizeHeight(height: 16, context: context),
              mainTextField(
                hintText: "Short Description",
                controller: taskProvider.taskDescription,
              ),
              sizeHeight(height: 16, context: context),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose an icon",
                      style: TextStyles.subTitle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 8, // Replace with the actual icon count.
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisExtent: 50,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIconIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIconIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.greyColor,
                              shape: BoxShape.circle,
                            ),
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Text(
                                'Icon $index', // Replace with actual icons.
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              sizeHeight(height: 16, context: context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Start Time",
                          style: TextStyles.subTitle.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => pickTime(context, taskProvider.taskStartDate),
                          child: Text(
                            taskProvider.taskStartDate.text.isNotEmpty
                                ? taskProvider.taskStartDate.text
                                : "Set Start Time",
                            style: TextStyles.subTitle.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "End Time",
                          style: TextStyles.subTitle.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => pickTime(context, taskProvider.taskEndDate),
                          child: Text(
                            taskProvider.taskEndDate.text.isNotEmpty
                                ? taskProvider.taskEndDate.text
                                : "Set End Time",
                            style: TextStyles.subTitle.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              sizeHeight(height: 16, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
