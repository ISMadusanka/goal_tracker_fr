
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/authScreens/resetpass_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../Static Data/text_styles.dart';

class OtpScreen extends StatefulWidget {
  static const String otpScreenRoute = "/otpScreen";
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
                  Text("Verification",style: TextStyles.heading1,),
                  const Spacer(),
                ],
              ),
              sizeHeight(height: 16+19,context: context),
              Text("Enter your email for the verification process. we will send 6 digits code to your email.",style: TextStyles.subTitle,textAlign: TextAlign.center,),
              sizeHeight(height: 24,context: context),
              Text("Code sent to ronaldrichards@gmail.com",style: TextStyles.subTitle,),
              sizeHeight(height: 12,context: context),
              Row(
                children: [
                  Expanded(
                    child: Pinput(
                      defaultPinTheme: PinTheme(
                        textStyle: TextStyles.subTitle,
                        height: 56,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: AppColors.titleColor)),
                      ),
                      length: 6,
                    ),
                  ),
                ],
              ),
              sizeHeight(height: 30,context: context),

              Row(
                children: [
                  Expanded(child: mainButton(title: "Verify",onTap: () {
                    Navigator.pushNamed(context, ResetPassword.resetPasswordRoutes);
                  },)),
                ],
              ),
              sizeHeight(height: 16,context: context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(children: [
                    TextSpan(text: "Don’t receive an code? ",style: TextStyles.subTitle.copyWith(fontWeight: FontWeight.w400)),
                    TextSpan(text: "resend now",style: TextStyles.subTitle.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.w600,),

                    ),
                  ])),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
