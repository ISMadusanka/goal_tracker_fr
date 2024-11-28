import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/profile_provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../Static Data/colors_file.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/dynamicsize.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/mainappbar.dart';

class EditeProfile extends StatefulWidget {
  static const String editeProfileRoute = "/editeProfile";
  const EditeProfile({super.key});

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(child: mainButton(title: "Save",onTap: () {
              Navigator.pop(context);
            },))
          ],
        ),
      ),
      appBar:  const MainAppBar(title: "Profile",isBack: true,),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
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
                  InkWell(
                    onTap: () {

                      profileProvider.pickImage();

                    },
                    child: Container(
                        height: 32,width: 32,
                        decoration: const BoxDecoration(
                            color: AppColors.containerColor,
                            shape: BoxShape.circle
                        ),
                        child: Center(child: SvgPicture.asset("assets/icons/Camera.svg"))),
                  ),
                ],
              ),
              sizeHeight(height: 24,context: context),
              mainTextField(hintText: "Enter your name",controller: profileProvider.editName),
              sizeHeight(height: 16,context: context),
              mainTextField(hintText: "Enter your email",controller: profileProvider.editEmail),
              sizeHeight(height: 16,context: context),
              IntlPhoneField(
                initialCountryCode: 'IN',
                initialValue: profileProvider.ccode,
                showCountryFlag: false,
                disableLengthCheck: true,
                controller: profileProvider.editNumber,
                onCountryChanged: (value) {
                  profileProvider.ccode = "+${value.dialCode}";
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:  const EdgeInsets.all(15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(color: AppColors.primaryColor,width: 2)),
                    hintText: "Enter your number",
                    hintStyle: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w400)
                ),
                style: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w700),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
