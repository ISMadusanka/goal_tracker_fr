import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Screens/Other%20Screen/edit_profile.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';
import '../../Widgets/mainappbar.dart';

class MyProfileScreen extends StatefulWidget {
  static const String myProfileScreenRoutes = "/myProfileScreen";
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late ProfileProvider profileProvider;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context,listen: false);

    profileProvider.editName.text = "Ronald richards";
    profileProvider.editNumber.text = "555-0123";
    profileProvider.editEmail.text = "ronaldrichards@gmail.com";
  }
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar:   MainAppBar(title: "Profile",isBack: true,actionIcon: InkWell(
        onTap: () {
          Navigator.pushNamed(context, EditeProfile.editeProfileRoute);
        },
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.containerColor,
              shape: BoxShape.circle
          ),
          height: 50,width: 50,child: Center(child: SvgPicture.asset("assets/icons/Edit.svg")),
        ),
      ),),

      backgroundColor: AppColors.bgColor,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                profileProvider.proImage != null ? Container(
                   height:100,width:100,
                   decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: FileImage(File(profileProvider.proImage!.path)),fit: BoxFit.cover)
                  ),
                ) :  SvgPicture.asset("assets/image/Profile-emty.svg"),
                Container(
                    height: 32,width: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.containerColor,
                      shape: BoxShape.circle
                    ),
                    child: Center(child: SvgPicture.asset("assets/icons/Camera.svg"))),
              ],
            ),
            sizeHeight(height: 24,context: context),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.containerColor
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name",style: TextStyles.subTitle.copyWith(fontSize: 15)),
                        Text(profileProvider.editName.text,style: TextStyles.subTitle,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            sizeHeight(height: 16,context: context),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.containerColor
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email address",style: TextStyles.subTitle.copyWith(fontSize: 15)),
                        Text(profileProvider.editEmail.text,style: TextStyles.subTitle,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            sizeHeight(height: 16,context: context),
            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.containerColor
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phone number",style: TextStyles.subTitle.copyWith(fontSize: 15)),
                        Text("(${profileProvider.ccode}) ${profileProvider.editNumber.text}",style: TextStyles.subTitle,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
