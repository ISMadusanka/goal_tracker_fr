
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';

import '../Static Data/text_styles.dart';

Widget taskContainer({context,required String icon,required String title,required String subtitle}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.containerColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xff404040)),
        child: Center(child: SvgPicture.asset(icon)),
        ),
        sizeHeight(height: 24,context: context),
        Text(title,style: TextStyles.heading1.copyWith(fontSize: 20),),
        Row(
          children: [
            Expanded(child: Text(subtitle,style: TextStyles.subTitle.copyWith(fontSize: 15,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,maxLines: 1,)),
          ],
        ),
      ],
    ),
  );
}
