// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/Other%20Screen/today_task.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/task_container.dart';

class HomeScreen extends StatefulWidget {

  static const String homeScreen = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/3.5,),
                  sizeHeight(height: 18,context: context),
                  Row(
                    children: [
                      Text("Today task",style: TextStyles.heading1.copyWith(fontSize: 20),),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, TodayTask.todayTaskRoute);
                          },
                          child: Text("View all",style: TextStyles.subTitle.copyWith(fontSize: 15),)
                      ),
                    ],
                  ),

                  sizeHeight(height: 16,context: context),

                  Row(
                    children: [
                      Expanded(child: taskContainer(icon: "assets/temp/walk 1.svg",subtitle: "Running up to 11km",title: "Running",context: context)),
                      const SizedBox(width: 16,),
                      Expanded(child: taskContainer(icon: "assets/temp/yoga 1.svg",subtitle: "Meditation up to 11km",title: "Meditation",context: context)),
                    ],
                  ),

                  sizeHeight(height: 16,context: context),
                  const Row(
                    children: [
                      Expanded(
                        child: BarChart(),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius:  BorderRadius.vertical(bottom: Radius.circular(30))
            ),
            padding:  const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                text: TextSpan(
                                    children: [
                                  TextSpan(text: "Hello,\n",style: TextStyles.heading1),
                                  TextSpan(text: "Welcome Back!",style: TextStyles.heading1),
                                ])),
                            WavingHandAnimation()
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          homeProvider.updateIndex(3);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: SvgPicture.asset("assets/icons/notification.svg",colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
                        ),
                      ),

                    ],
                  ),
                  sizeHeight(height: 16,context: context),
                  homeProvider.buildHeader(context),
                  sizeHeight(height: 16,context: context),
                  homeProvider.buildDaysOfWeek(),
                  homeProvider.buildCalendarDays(),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class BarChart extends StatefulWidget {
  const BarChart({super.key});

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {

  final List<double> data = [50, 80, 120, 70, 90, 60, 100];

  final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  List height = [];

  @override
  void initState() {
    super.initState();
    for(int i =0;i<data.length;i++){
      height.add(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Total activities",style: TextStyles.heading1.copyWith(fontSize: 20,color: AppColors.bgColor),),
          const SizedBox(height: 6,),
          Text("29%",style: TextStyles.heading1.copyWith(color: AppColors.bgColor),),
          sizeHeight(height: 16,context: context),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < data.length; i++)
                Builder(
                  builder: (context) {

                    WidgetsBinding.instance.addPostFrameCallback((_){
                      setState(() {
                        height[i] = data[i];
                      });
                    });

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width / data.length - 28,
                              height: 150,
                              decoration: BoxDecoration(
                                color: AppColors.bgColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),

                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              width: MediaQuery.of(context).size.width / data.length - 28,
                              height: height[i],
                              decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8.0),

                        Text(days[i]),

                      ],
                    );
                  }
                ),
            ],
          ),
        ],
      ),
    );
  }
}


class WavingHandAnimation extends StatefulWidget {
  @override
  _WavingHandAnimationState createState() => _WavingHandAnimationState();
}

class _WavingHandAnimationState extends State<WavingHandAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchTodayTasks();
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(3 * _waveAnimation.value, -3 * _waveAnimation.value),
          child: Text("👋",style: TextStyles.heading1),
        );
      },
    );
  }
}

