import 'package:flutter/material.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Static%20Data/text_styles.dart';

Widget mainButton({required String title,Color? bgColor,void Function()? onTap,Color? titleColor}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromHeight(56),
          backgroundColor: bgColor ?? AppColors.primaryColor,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      )),
      onPressed: onTap ?? (){}, child: Text(title,style: TextStyles.buttonTitle.copyWith(color: titleColor),));
}
Widget mainOutlineButton({required String title,Color? bgColor,void Function()? onTap,Color? titleColor}){
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      onPressed: onTap, child: Text(title,style: TextStyles.buttonTitle.copyWith(color: titleColor ??  AppColors.primaryColor),));
}
