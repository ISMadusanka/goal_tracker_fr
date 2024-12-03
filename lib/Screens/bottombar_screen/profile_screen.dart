import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/Other%20Screen/myprofile_screen.dart';
import 'package:habittracker/Screens/Other%20Screen/setting_screen.dart';
import 'package:habittracker/Screens/Other%20Screen/today_task.dart';
import 'package:habittracker/Screens/authScreens/login_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/providers/profile_provider.dart';
import 'package:habittracker/services/api_service.dart';
import 'package:provider/provider.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/mainappbar.dart';

class ProfileScreen extends StatefulWidget {
  static const profileScreenRoutes = "/profileScreen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return  Scaffold(
      appBar:  const MainAppBar(title: "Profile",),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             children: [
               profileProvider.proImage != null ? Container(
                 height:100,width:100,
                 decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(image: FileImage(File(profileProvider.proImage!.path)),fit: BoxFit.cover)
                 ),
               ) : SvgPicture.asset("assets/image/Profile-emty.svg"),
                 sizeHeight(height: 16,context: context),
                 Text("Ronald richards",style: TextStyles.subTitle.copyWith(fontSize: 18),),
                 const SizedBox(height: 4,),
                 Text("ronaldrichards@gmail.com",style: TextStyles.subTitle.copyWith(color: const Color(0xffC0C0C0)),),
             sizeHeight(height: 24,context: context),
             ListView.separated(
               physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemBuilder: (context, index) {
             return InkWell(
               onTap: () {
                 switch(index){
                   case 0:
                     Navigator.pushNamed(context, MyProfileScreen.myProfileScreenRoutes);
                     break;
                   case 1:
                     Navigator.pushNamed(context, TodayTask.todayTaskRoute);
                     break;
                   case 3:
                     Navigator.pushNamed(context, SettingScreen.settingScreenRoute);
                     break;
                   case 4:
                     showDialog(context: context, builder: (context) {
                       return AlertDialog(
                         titlePadding: EdgeInsets.zero,
                         backgroundColor: AppColors.containerColor,
                         insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                         title: Container(padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12),
                             color:  AppColors.containerColor,
                           ),
                           child: Column(
                             children: [
                               Text("Are you sure you want to log out?",style: TextStyles.heading1.copyWith(fontSize: 20),textAlign: TextAlign.center,),
                               sizeHeight(height: 28,context: context),
                               Row(
                                 children: [
                                   Expanded(
                                     child: mainOutlineButton(title: 'Cancel',onTap: () {
                                       Navigator.pop(context);
                                     },),
                                   ),const SizedBox(width: 20,),
                                   Expanded(
                                     child: mainButton(title: "Log out",onTap: () async {
                                      await ApiService().clearToken();
                                       Navigator.pushNamedAndRemoveUntil(context, LoginScreen.loginScreenRoutes, (route) => false);
                                     },),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),);
                     },);
                    break;
                 }

               },
               child: Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(16),
                   color: AppColors.containerColor,

                 ),
                 child: Row(
                   children: [
                   Container(height: 50,width: 50,decoration: const BoxDecoration(
                     color: Color(0xff1E1E1E),
                     shape: BoxShape.circle,
                   ),
                   child: Center(child: SvgPicture.asset("${profileProvider.profileData[index]["icon"]}")),
                   ),
                   const SizedBox(width: 16,),
                   Text("${profileProvider.profileData[index]["title"]}",style: TextStyles.subTitle,),
                   const Spacer(),
                   SvgPicture.asset("assets/icons/arrow right.svg"),
                 ],),
               ),
             );
             }, separatorBuilder: (context, index) {
             return const SizedBox(height: 16,);
             }, itemCount: profileProvider.profileData.length)
             ],
          ),
        ),
      ),
    );
  }
}
