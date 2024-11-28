import 'package:flutter/material.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/maintextfield.dart';
import '../../Widgets/mainappbar.dart';

class ChangePassword extends StatefulWidget {
  static const String changePasswordRoute = "/changePassword";
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
            Expanded(
                child: mainButton(
              title: "Save",
              onTap: () {},
            ))
          ],
        ),
      ),

      appBar: const MainAppBar(
        title: "Change Password",
        isBack: true,
      ),

      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Text(
              "Change your password today it's time to take back control of your online security",
              style: TextStyles.subTitle,
              textAlign: TextAlign.center,
            ),
            sizeHeight(height: 24, context: context),
            mainTextField(
              controller: profileProvider.chanePassController,
              hintText: "password",
              obscureText: profileProvider.changePass,
              tralingIcon: "assets/icons/Eye.svg",
              trallingOntap: () {
                profileProvider.updateChangePass();
              },
            ),

            sizeHeight(height: 16, context: context),
            mainTextField(
              controller: profileProvider.newPassController,
              hintText: "new password",
              obscureText: profileProvider.newPass,
              tralingIcon: "assets/icons/Eye.svg",
              trallingOntap: () {
                profileProvider.updateNewPass();
              },
            ),

            sizeHeight(height: 16, context: context),
            mainTextField(
              controller: profileProvider.confrormPassController,
              hintText: "Confrorm password",
              obscureText: profileProvider.conformPass,
              tralingIcon: "assets/icons/Eye.svg",
              trallingOntap: () {
                profileProvider.updateConformPass();
              },
            ),
            sizeHeight(height: 16, context: context),
          ],
        ),
      ),
    );
  }
}
