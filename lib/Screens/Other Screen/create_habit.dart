import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habittracker/Screens/bottombar_screen/bottomnav_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../Static Data/text_styles.dart';
import '../../Widgets/mainbutton.dart';
import '../../Widgets/mainappbar.dart';


class CreateHabit extends StatefulWidget {
  static const String createHabitRoute = "/createHabit";
  const CreateHabit({super.key});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(child: mainButton(title: "Save",onTap: () {

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
                        sizeHeight(height: 28,context: context),
                        Text("Habit add success",style: TextStyles.heading1,textAlign: TextAlign.center,),
                        sizeHeight(height: 13,context: context),
                        Text("You have successfully create new habit now go to home. for continue journey.",style: TextStyles.subTitle,textAlign: TextAlign.center,),
                        sizeHeight(height: 28,context: context),
                        mainButton(title: "Go to Home",onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, BottomNavScreen.bottomNavRoute, (route) => false);
                        },),
                      ],
                    ),
                  ),);
              },);

            },))
          ],
        ),
      ),
      appBar:  const MainAppBar(title: "Create custom habit",isBack: true,),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              mainTextField(hintText: "Name of habit"),
              sizeHeight(height: 16,context: context),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Choose an icon",style: TextStyles.subTitle.copyWith(color: Colors.black)
                      ,),
                    const SizedBox(height: 10,),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeProvider.todayList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisExtent: 50,mainAxisSpacing: 16),
                        itemBuilder: (context, index) {
        
                          return Container(
                            decoration: const BoxDecoration(
                                color: AppColors.greyColor,
                                shape: BoxShape.circle
                            ),
                            height: 30,width: 30,child: Center(child: SvgPicture.asset( homeProvider.todayList[index]["icon"],colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),)),
                          );
        
                        },),
                  ],
                ),
              ),
              sizeHeight(height: 16,context: context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  children: [
                    Text("Frequency",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    const Spacer(),
                    Text("Every day",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    SvgPicture.asset("assets/icons/arrow right.svg",colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
                  ],
                ),
              ),
              sizeHeight(height: 16,context: context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  children: [
                    Text("Repeats",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    const Spacer(),
                    Text("1 times per day",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    SvgPicture.asset("assets/icons/arrow right.svg",colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
                  ],
                ),
              ),
              sizeHeight(height: 16,context: context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  children: [
                    Text("Reminders",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    const Spacer(),
                    Text("11:00 PM",style: TextStyles.subTitle.copyWith(color: Colors.black)),
                    SvgPicture.asset("assets/icons/arrow right.svg",colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
                  ],
                ),
              ),
              sizeHeight(height: 16,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
