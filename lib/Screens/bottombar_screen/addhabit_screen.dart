import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Screens/Other%20Screen/create_habit.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';
import '../../Widgets/mainappbar.dart';
import '../../providers/home_provider.dart';

class AddHabitScreen extends StatefulWidget {
  static const addHabitScreen = "/AddHabitScreen";
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(child: mainButton(title: "Create custom goal",onTap: () {
              Navigator.pushNamed(context, CreateHabit.createHabitRoute);
            },))
          ],
        ),
      ),
        appBar:  const MainAppBar(title: "Add new goal",),
        backgroundColor: AppColors.bgColor,
        body: ListView.separated(
           physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Container(
                // height: 72,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.containerColor),
                child: Row(
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xff404040)),
                      child: Center(
                          child: SvgPicture.asset('${homeProvider.todayList[index]["icon"]}')),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                        child: Text(
                      "${homeProvider.todayList[index]["subtitle"]}",
                      style: TextStyles.subTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: homeProvider.todayList.length));
  }
}
