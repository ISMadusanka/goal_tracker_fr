import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';

import '../../Static Data/text_styles.dart';
import '../../Widgets/mainappbar.dart';

class NotificationScreen extends StatefulWidget {
  static const notificationScreen = "/NotificationScreen";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar:  const MainAppBar(title: "Notifications",),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16,);
        },
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff3D3D3D)

                  ),
                  child: Center(child: SvgPicture.asset("assets/icons/notificationfill.svg",colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),)),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time to crush your goals ",style: TextStyles.heading1.copyWith(fontSize: 20),overflow: TextOverflow.ellipsis,maxLines: 1,),
                      const SizedBox(height: 6,),
                      Text("Time to crush your goals! don't forgot to track your study tim4 today",style: TextStyles.subTitle,overflow: TextOverflow.ellipsis,maxLines: 4,),
                      const SizedBox(height: 8,),
                      Text("11 min ago",style: TextStyles.subTitle.copyWith(fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 4,),
                    ],
                  ),
                ),


              ],
            ),
          );
      },),
    );
  }
}
