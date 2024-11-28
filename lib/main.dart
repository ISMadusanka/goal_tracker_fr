import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habittracker/Screens/splash_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/core/routes.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:habittracker/providers/task_provider.dart';
import 'package:habittracker/providers/onboarding_provider.dart';
import 'package:habittracker/providers/profile_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: AppColors.bgColor));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardingProvider(),),
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
        ChangeNotifierProvider(create: (context) => ProfileProvider(),),
        ChangeNotifierProvider(create: (context) => TaskProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goal Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor,primary: AppColors.primaryColor),
          primaryColor: AppColors.primaryColor,
          splashColor: Colors.transparent,
          appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
          useMaterial3: true,
          hoverColor: Colors.transparent,
          // highlightColor: Colors.transparent,
        ),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.splashScreenRoutes,
      ),
    );
  }
}

