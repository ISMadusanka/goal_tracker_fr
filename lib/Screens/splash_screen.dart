import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/onboarding_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Static%20Data/images.dart';

import '../Static Data/text_styles.dart';

class SplashScreen extends StatefulWidget {
  static const String splashScreenRoutes = "/splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Future.delayed(const Duration(seconds: 3),() {
      Navigator.of(context).pushNamedAndRemoveUntil(OnBoardingScreen.onBoardingRoute,(route) => false,);
    },);
    controller.forward();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
              opacity: animation,
              child: SvgPicture.asset(ImagesPath.appLogo)),
          const SizedBox(height: 12,),
            Text("Habit tracker App",style: TextStyles.heading1,),
          const Row()
        ],),
    );
  }
}
