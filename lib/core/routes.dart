import 'package:flutter/cupertino.dart';
import 'package:habittracker/Screens/Other%20Screen/change_password.dart';
import 'package:habittracker/Screens/Other%20Screen/create_habit.dart';
import 'package:habittracker/Screens/Other%20Screen/edit_profile.dart';
import 'package:habittracker/Screens/Other%20Screen/myprofile_screen.dart';
import 'package:habittracker/Screens/Other%20Screen/setting_screen.dart';
import 'package:habittracker/Screens/Other%20Screen/today_task.dart';
import 'package:habittracker/Screens/authScreens/forgot_password.dart';
import 'package:habittracker/Screens/authScreens/otp_screen.dart';
import 'package:habittracker/Screens/authScreens/resetpass_screen.dart';
import 'package:habittracker/Screens/authScreens/singup_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/bottomnav_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/home_screen.dart';
import 'package:habittracker/Screens/onboarding_screen.dart';
import 'package:habittracker/Screens/splash_screen.dart';

import '../Screens/authScreens/login_screen.dart';

class Routes{
  static Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case SplashScreen.splashScreenRoutes: return CupertinoPageRoute(
          builder: (context) =>  const SplashScreen()
      );
      case LoginScreen.loginScreenRoutes: return CupertinoPageRoute(
          builder: (context) =>  const LoginScreen()
      );case OnBoardingScreen.onBoardingRoute: return CupertinoPageRoute(
          builder: (context) =>  const OnBoardingScreen()
      );
      case SingUpScreen.singUpScreenRoutes: return CupertinoPageRoute(
          builder: (context) =>  const SingUpScreen()
      );
      case ForgotPassword.forgotPasswordRoute: return CupertinoPageRoute(
          builder: (context) =>  const ForgotPassword()
      );
      case OtpScreen.otpScreenRoute: return CupertinoPageRoute(
          builder: (context) =>  const OtpScreen()
      );
      case ResetPassword.resetPasswordRoutes: return CupertinoPageRoute(
          builder: (context) =>  const ResetPassword()
      );
      case BottomNavScreen.bottomNavRoute: return CupertinoPageRoute(
          builder: (context) =>  const BottomNavScreen()
      );
      case TodayTask.todayTaskRoute: return CupertinoPageRoute(
          builder: (context) =>  const TodayTask()
      );
      case CreateHabit.createHabitRoute: return CupertinoPageRoute(
          builder: (context) =>  const CreateHabit()
      );
      case MyProfileScreen.myProfileScreenRoutes: return CupertinoPageRoute(
          builder: (context) =>  const MyProfileScreen()
      );
      case EditeProfile.editeProfileRoute: return CupertinoPageRoute(
          builder: (context) =>  const EditeProfile()
      );
      case SettingScreen.settingScreenRoute: return CupertinoPageRoute(
          builder: (context) =>  const SettingScreen()
      );
      case ChangePassword.changePasswordRoute: return CupertinoPageRoute(
          builder: (context) =>  const ChangePassword()
      );
      case HomeScreen.homeScreen: return CupertinoPageRoute(
          builder: (context) =>  const HomeScreen()
      );
      default: return null;
    }
  }
}