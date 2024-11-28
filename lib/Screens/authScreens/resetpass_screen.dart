
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/authScreens/login_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';

class ResetPassword extends StatefulWidget {
  static const String resetPasswordRoutes = "/resetPassword";
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.containerColor,
                          shape: BoxShape.circle
                      ),
                      height: 40,width: 40,child: Center( child: SvgPicture.asset("assets/icons/arrow left.svg")),
                    ),
                  ),
                  const Spacer(),
                  Text("Reset password",style: TextStyles.heading1,),
                  const Spacer(),
                ],
              ),
              sizeHeight(height: 16+19,context: context),
              Text("Enter your email for the verification process. we will send 6 digits code to your email.",style: TextStyles.subTitle,textAlign: TextAlign.center,),
              sizeHeight(height: 24,context: context),
              mainTextField(controller:authProvider.newPass, hintText: "New Password",tralingIcon:"assets/icons/Eye.svg",obscureText: authProvider.isShowNewPass,trallingOntap: () {
                authProvider.updateIsShowNewPass();
              },),
              sizeHeight(height: 16,context: context),

              mainTextField(controller:authProvider.confirmPass, hintText: "Confirm Password",tralingIcon:"assets/icons/Eye.svg",obscureText: authProvider.isShowConfirmPass,trallingOntap: () {
                authProvider.updateIsShowConfirmPass();
              },),

              sizeHeight(height: 30,context: context),
              Row(
                children: [
                  Expanded(child: mainButton(title: "Reset password",onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        backgroundColor: AppColors.containerColor,
                        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                        title: Container(padding: const EdgeInsets.all(19),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:  AppColors.containerColor,
                          ),
                          child: Column(
                          children: [
                            Container(height: 120,width: 120,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE6F8EE)
                            ),child: Center(child: SvgPicture.asset("assets/icons/success.svg",height: 50,width: 50,)),),
                            sizeHeight(height: 25,context: context),
                            Text("Password reset success",style: TextStyles.heading1,textAlign: TextAlign.center,),
                            sizeHeight(height: 12,context: context),
                            Text("You have successfully change your password use new password to log in",style: TextStyles.subTitle,textAlign: TextAlign.center
                              ,),
                            sizeHeight(height: 25,context: context),
                            mainButton(title: "Go to Login",onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.loginScreenRoutes, (route) => false);
                            },),
                          ],
                                                ),
                        ),);
                    },);

                  },)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
