import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/authScreens/login_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';
import '../Static Data/text_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String onBoardingRoute = "/onBoardingScreen";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingProvider onBoardingProvider;
  @override
  Widget build(BuildContext context) {
    onBoardingProvider = Provider.of<OnBoardingProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onBoardingProvider.pageController,
                itemCount: onBoardingProvider.onBoardingData.length,
                onPageChanged: (value) {
                  onBoardingProvider.upDateCurrentIndex(value);
                },
                itemBuilder: (context, index) {

                  return Column(
                    children: [
                      SvgPicture.asset("${onBoardingProvider.onBoardingData[index]["image"]}"),
                      const Spacer(),
                      // SizedBox(height: MediaQuery.of(context).size.height /10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Text("${onBoardingProvider.onBoardingData[index]["title"]}",style: TextStyles.heading1,textAlign: TextAlign.center,),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.017,),
                            Text("${onBoardingProvider.onBoardingData[index]["subTitle"]}",style: TextStyles.subTitle,textAlign: TextAlign.center,),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.026,),
                          ],
                        ),
                      ),
                    ],
                  );

                },),
            ),
            // Spacer(flex: onBoardingProvider.currentIndex == onBoardingProvider.onBoardingData.length-1? 4 : 7,),
            Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      onBoardingProvider.onBoardingData.length, (index) => Container(
                    margin:  const EdgeInsets.all(3),
                    height: 7,width:onBoardingProvider.currentIndex == index?16 : 7,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: onBoardingProvider.currentIndex == index? AppColors.primaryColor :  const Color(0xff461F16),
                      // shape: BoxShape.circle
                    ),
                  )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.035,),
              Row(
                children: [
                  Expanded(child: mainButton(title: onBoardingProvider.currentIndex == onBoardingProvider.onBoardingData.length-1? "Get Started":"Next",bgColor: AppColors.primaryColor,onTap: () {
                    if(onBoardingProvider.currentIndex == onBoardingProvider.onBoardingData.length-1){
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.loginScreenRoutes, (route) => false);
                    }else{
                      onBoardingProvider.upDatePageController(onBoardingProvider.currentIndex+1);
                    }
        
                  },)),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.017,),
                  InkWell(
                      onTap: () {
                        onBoardingProvider.currentIndex == onBoardingProvider.onBoardingData.length-1? null:
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.loginScreenRoutes, (route) => false);
                      },
                      child: Text("Skip",style: TextStyles.subTitle.copyWith(color: onBoardingProvider.currentIndex == onBoardingProvider.onBoardingData.length-1? Colors.transparent : null))),
                ],
              ),
        
            ],
          ),
        ),
        
            // const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
