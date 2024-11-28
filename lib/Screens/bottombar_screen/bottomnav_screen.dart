import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/providers/home_provider.dart';
import 'package:provider/provider.dart';
import '../../Static Data/text_styles.dart';

class BottomNavScreen extends StatefulWidget {
  static const String bottomNavRoute = "/bottomNavScreen";
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
        // backgroundColor: AppColors.bgColor,
        bottomNavigationBar: Container(
          color: AppColors.containerColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int a = 0; a < homeProvider.bottomData.length; a++)
                InkWell(
                  onTap: () {
                    homeProvider.updateIndex(a);
                  },
                  child: a == 2 ? Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width/5,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle),
                  child: Center(
                      child: SvgPicture.asset(
                          homeProvider.bottomData[a]["Icon"])),
                ) :
                SizedBox(
                  width: MediaQuery.of(context).size.width/5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                          decoration: BoxDecoration(
                              color: homeProvider.currentIndex == a ?Colors.white.withOpacity(0.15) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: SvgPicture.asset( homeProvider.currentIndex == a ?homeProvider.bottomData[a]["filledIcon"] : homeProvider.bottomData[a]["Icon"])
                      ),
                      const SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              homeProvider.bottomData[a]["title"],
                              style: TextStyles.subTitle.copyWith(
                                  fontSize: 13
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      body: homeProvider.bottomData[homeProvider.currentIndex]["page"]
    );
  }
}
