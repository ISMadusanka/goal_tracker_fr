import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Static%20Data/text_styles.dart';

Widget mainTextField({TextEditingController? controller,required String hintText,bool? obscureText,String? tralingIcon,void Function()? trallingOntap,String? errorType}){
  return TextFormField(
    obscureText: obscureText ?? false,
    controller: controller ?? TextEditingController(),
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
        suffixIcon: tralingIcon?.isNotEmpty ?? false ?  InkWell(
          onTap: trallingOntap ?? (){},
          child: SizedBox(
              height: 25,
              width: 25,
              child: Center(child: SvgPicture.asset(tralingIcon!))),
        ) : null,
      contentPadding:  const EdgeInsets.all(15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(color: AppColors.primaryColor,width: 2)),
      hintText: hintText,
      hintStyle: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w400)
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please Enter a $errorType';
      }
      return null;
    },
    style: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w700),
  );
}