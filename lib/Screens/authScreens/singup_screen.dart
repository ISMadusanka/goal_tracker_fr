import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Static%20Data/text_styles.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../bottombar_screen/bottomnav_screen.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});
  static const String singUpScreenRoutes = "/singUpScreen";
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  late AuthProvider authProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var pageSize = MediaQuery.of(context).size.height;
    var notifySize = MediaQuery.of(context).padding.top;

    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: pageSize - ( notifySize),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Text("Sign up",style: TextStyles.heading1,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
                    Row(
                      children: [
                        Flexible(child: Text("Explore a new world of possibilities with sign up",style: TextStyles.subTitle,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                      ],
                    ),
                    sizeHeight(height: 24,context: context),
                    mainTextField(controller: authProvider.singUpName,hintText:"Enter your name",errorType: "Name"),
                    sizeHeight(height: 16,context: context),
                    mainTextField(controller: authProvider.singUpEmail,hintText:"Enter your email address",errorType: "Email"),
                    sizeHeight(height: 16,context: context),
                    IntlPhoneField(

                      validator: (value) {
                        if (value!.number.isEmpty) {
                          return 'Please Enter a Number';
                        }
                        return null;
                      },
                      initialCountryCode: 'IN',
                      showCountryFlag: false,
                      disableLengthCheck: true,
                      controller: authProvider.singUpNumber,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:  const EdgeInsets.all(15),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(color: AppColors.primaryColor,width: 2)),
                          hintText: "Enter your number",
                          hintStyle: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w400)
                      ),
                      style: TextStyles.subTitle.copyWith(color: Colors.black,fontWeight: FontWeight.w700),

                    ),
                    sizeHeight(height: 16,context: context),
                    mainTextField(controller: authProvider.singUpPassword,hintText:"Enter your password",obscureText: authProvider.singUpIsShowText,tralingIcon: authProvider.singUpIsShowText? "assets/icons/Eye.svg" : "assets/icons/Eyeopen.svg",errorType: "Password",trallingOntap: () {
                      authProvider.updateSingUpIsShow();
                    },),
                    sizeHeight(height: 30,context: context),
                    Row(

                      children: [
                        Expanded(child: mainButton(title: "Sing Up",onTap: () async {
                          final isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            // Navigator.pushNamedAndRemoveUntil(context, BottomNavScreen.bottomNavRoute, (route) => false);
                            // return;
                             _formKey.currentState!.save();
                             bool res= await authProvider.signupUser(context);
                              if(res){
                                Navigator.pushNamedAndRemoveUntil(context, BottomNavScreen.bottomNavRoute, (route) => false);
                              }
                          }
                          //_formKey.currentState!.save();
                        },)),
                      ],
                    ),
                    sizeHeight(height: 16,context: context),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.containerColor,height: 1,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("or continue with",style: TextStyles.subTitle,),
                        ),
                        const Expanded(child: Divider(color: AppColors.containerColor,height: 1,)),
                      ],
                    ),
                    sizeHeight(height: 16,context: context),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: ShapeDecoration(
                              color: AppColors.containerColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/google.svg"),
                              const SizedBox(width: 8,),
                              Text("Google",style: TextStyles.subTitle.copyWith(fontWeight: FontWeight.w600,fontSize: 16),)

                            ],
                          ),
                          ),
                        ),
                        sizeWidth(width: 16,context: context),
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: ShapeDecoration(
                              color: AppColors.containerColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/facebook.svg"),
                              const SizedBox(width: 8,),
                              Text("Facebook",style: TextStyles.subTitle.copyWith(fontWeight: FontWeight.w600,fontSize: 16),)

                            ],
                          ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(text: TextSpan(children: [
                          TextSpan(text: "Already have an account? ",style: TextStyles.subTitle.copyWith(fontWeight: FontWeight.w400)),
                          TextSpan(text: "Sign in",style: TextStyles.subTitle.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.w600),recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.pop(context);
                          }),
                        ])),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
