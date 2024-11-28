import 'package:flutter/material.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../Widgets/mainappbar.dart';
import '../../Widgets/task_container.dart';

class TodayTask extends StatefulWidget {
  static const String todayTaskRoute ="/todayTask";
  const TodayTask({super.key});

  @override
  State<TodayTask> createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:  const MainAppBar(title: "Today Task",isBack: true,),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16,mainAxisExtent: 160),
              itemCount: homeProvider.todayList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return taskContainer(icon: homeProvider.todayList[index]["icon"],subtitle: homeProvider.todayList[index]["subtitle"],title: homeProvider.todayList[index]["title"],context: context);
            },),
          ),
        ),
      ),
    );
  }
}
