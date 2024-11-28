import 'package:flutter/material.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainappbar.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/task_container.dart';
import '../Other Screen/today_task.dart';
import 'home_screen.dart';

class ProgressScreen extends StatefulWidget {
  static const progressScreenRoutes = "/progressScreen";
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  final List<double> data = [0.4, 0.6, 0.8, 0.3, 0.5];
  late HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return  Scaffold(
      appBar: const MainAppBar(title: "Progress",),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                        // height: 250,
                        decoration: BoxDecoration(
                          color: AppColors.containerColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [

                            const SizedBox(width: 16,),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,width: 12,decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                            color: AppColors.secondaryColor
                                        ),
                                        ),const SizedBox(width: 6,),
                                        Text("Habits",style: TextStyles.subTitle.copyWith(fontSize: 14)),
                                      ],
                                    ),
                                    Text("85",style: TextStyles.subTitle.copyWith(fontSize: 16)),
                                  ],
                                ),

                                sizeHeight(height: 12,context: context),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,width: 12,decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                            color: AppColors.primaryColor
                                        ),
                                        ),const SizedBox(width: 6,),
                                        Text("Check-ins",style: TextStyles.subTitle.copyWith(fontSize: 14)),
                                      ],
                                    ),
                                    Text("56",style: TextStyles.subTitle.copyWith(fontSize: 16)),
                                  ],
                                ),

                                sizeHeight(height: 12,context: context),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,width: 12,decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                            color: Color(0xff5451DC)
                                        ),
                                        ),const SizedBox(width: 6,),
                                        Text("Mood tracker",style: TextStyles.subTitle.copyWith(fontSize: 14)),
                                      ],
                                    ),
                                    Text("11",style: TextStyles.subTitle.copyWith(fontSize: 16)),
                                  ],
                                ),

                              ],
                            ),

                            const Spacer(),

                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 200,
                                // child: SfCircularChart(
                                //     margin: EdgeInsets.zero,
                                //     series: <CircularSeries> [
                                //       // Renders radial bar chart
                                //       RadialBarSeries<ChartData, String>(
                                //           cornerStyle: CornerStyle.bothCurve,
                                //           useSeriesColor: true,
                                //           innerRadius: "20",
                                //           trackOpacity: 0.3,
                                //           gap: "10%",
                                //           dataSource: chartData,
                                //           pointColorMapper: (ChartData data, _) => data.color,
                                //           xValueMapper: (ChartData sales, _) => sales.x,
                                //           yValueMapper: (ChartData sales, _) => sales.y,
                                //       )
                                //     ]
                                //   ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  sizeHeight(height: 16,context: context),
                  Row(
                    children: [
                      Text("Daily task",style: TextStyles.heading1.copyWith(fontSize: 20),),
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
                ],
              ),
            ),
            SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    const SizedBox(width: 16,),

                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 16,);
                      },
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return SizedBox(
                          width: 150,
                          child: taskContainer(icon: homeProvider.todayList[index]["icon"],subtitle: homeProvider.todayList[index]["subtitle"],title: homeProvider.todayList[index]["title"],context: context)
                        );
                      },
                    ),

                    const SizedBox(width: 16,),

                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: BarChart(),
                  ),
                ],
              ),
            ),

            const SimpleBarChart(),
            sizeHeight(height: 16,context: context),
          ],
        ),
      ),
    );
  }
  final List<ChartData> chartData = [
    ChartData('David', 56 ,   AppColors.primaryColor),
    ChartData('Steve', 100,  AppColors.secondaryColor),
    ChartData('Jack',  11 ,   const Color(0xff5451DC)),
  ];
}

class ChartData {
  ChartData(this.x, this.y,this.color);
  final String x;
  final double y;
  final Color color;
}

class SimpleBarChart extends StatefulWidget {
  const SimpleBarChart({super.key});

  @override
  State<SimpleBarChart> createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  final List<double> data = [20, 30, 60, 30, 40, 13];
  int selectBar = -1;
  List heights = [];

  @override
  void initState() {
    super.initState();
    for(int a=0;a<data.length;a++){
      heights.add(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = data.reduce((value, element) => value > element ? value : element);
    final step = (maxValue / 5).ceil();

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.containerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Average bpm",style: TextStyles.heading1.copyWith(fontSize: 20),),
          RichText(
           text: TextSpan(
               children: [
             TextSpan(text: "29",style: TextStyles.heading1),
             TextSpan(text: " bpm",style:TextStyles.subTitle),
          ])),

          sizeHeight(height: 16,context: context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  (maxValue / step).ceil() + 1,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('${maxValue - index * step}', style: TextStyles.subTitle,),
                      ),
                ),
              ),

              const SizedBox(width: 8.0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                       data.length,
                        (index) {
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            setState(() {
                              heights[index] = (data[index] / maxValue) * 200.0;
                            });
                          });

                      return Column(
                      children: [
                        Tooltip(
                          onTriggered: () {
                            setState(() {
                              selectBar = index;
                            });
                          },
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          textAlign: TextAlign.center,
                          message: '${data[index]}',
                          textStyle: TextStyles.subTitle,
                          verticalOffset: -(data[index]+60),
                          triggerMode: TooltipTriggerMode.tap,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            width: 30.0,
                            height: heights[index], // Scaling bar height
                            decoration: BoxDecoration(
                              color: selectBar == index ? AppColors.primaryColor : const Color(0xff565656),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(7))
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${data[index]}',
                          style: TextStyles.subTitle,
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


