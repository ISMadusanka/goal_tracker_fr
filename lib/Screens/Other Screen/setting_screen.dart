import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Screens/Other%20Screen/change_password.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';
import '../../Widgets/dynamicsize.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/mainappbar.dart';
import '../../providers/profile_provider.dart';
import '../authScreens/login_screen.dart';

class SettingScreen extends StatefulWidget {
  static const String settingScreenRoute = "/SettingScreen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar:  const MainAppBar(title: "Setting",isBack: true,),
      backgroundColor: AppColors.bgColor,
      body:  ListView.separated(
        padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                switch(index){
                  case 0:
                    Navigator.pushNamed(context, ChangePassword.changePasswordRoute);
                    break;
                  case 3:
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
                              Container(height: 100,width: 100,decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE6F8EE)
                              ),child: Center(child: SvgPicture.asset("assets/icons/delete-vector.svg",height: 50,width: 50,)),),
                              sizeHeight(height: 28,context: context),
                              Text("Are you sure you want to delete account ?",style: TextStyles.heading1.copyWith(fontSize: 20),textAlign: TextAlign.center
                                ,),
                              sizeHeight(height: 28,context: context),
                              Row(
                                children: [
                                  Expanded(
                                    child: mainOutlineButton(title: 'No',onTap: () {
                                      Navigator.pop(context);
                                    },),
                                  ),const SizedBox(width: 20,),
                                  Expanded(
                                    child: mainButton(title: "Yes",onTap: () {
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
                      child: Center(child: SvgPicture.asset("${profileProvider.settingData[index]["icon"]}")),
                    ),
                    const SizedBox(width: 16,),
                    Text("${profileProvider.settingData[index]["title"]}",style: TextStyles.subTitle,),
                    const Spacer(),
                    SvgPicture.asset("assets/icons/arrow right.svg"),
                  ],),
              ),
            );
          }, separatorBuilder: (context, index) {
        return const SizedBox(height: 16,);
      }, itemCount: profileProvider.settingData.length),
    );
  }
}
