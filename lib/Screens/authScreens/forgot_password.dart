
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/authScreens/otp_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';

class ForgotPassword extends StatefulWidget {
  static const String forgotPasswordRoute = "/forgotPassword";
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                  Text("Forgot password",style: TextStyles.heading1,),
                const Spacer(),
                ],
              ),
              sizeHeight(height: 16+19,context: context),
              Text("Enter your email for the verification process. we will send 6 digits code to your email.",style: TextStyles.subTitle,textAlign: TextAlign.center,),
              sizeHeight(height: 24,context: context),
              mainTextField(controller: authProvider.forgotEmail, hintText: "Enter your email"),
              sizeHeight(height: 30,context: context),
              Row(
                children: [
                  Expanded(child: mainButton(title: "Send",onTap: () {
                    Navigator.pushNamed(context, OtpScreen.otpScreenRoute);
                  })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
