import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habittracker/Screens/authScreens/forgot_password.dart';
import 'package:habittracker/Screens/authScreens/singup_screen.dart';
import 'package:habittracker/Screens/bottombar_screen/bottomnav_screen.dart';
import 'package:habittracker/Static%20Data/colors_file.dart';
import 'package:habittracker/Static%20Data/text_styles.dart';
import 'package:habittracker/Widgets/dynamicsize.dart';
import 'package:habittracker/Widgets/mainbutton.dart';
import 'package:habittracker/Widgets/maintextfield.dart';
import 'package:habittracker/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String loginScreenRoutes = "/loginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pageSize = MediaQuery.of(context).size.height;
    var notifySize = MediaQuery.of(context).padding.top;
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: pageSize - ( notifySize),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Text("Log in",style: TextStyles.heading1,),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
                    Row(
                      children: [
                        Flexible(child: Text("Explore a world of possibilities with log in",style: TextStyles.subTitle,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                      ],
                    ),
                    sizeHeight(height: 24,context: context),
                    mainTextField(controller: authProvider.loginEmail,hintText:"Enter your email address",errorType: "Email"),
                    sizeHeight(height: 16,context: context),
                    mainTextField(controller: authProvider.loginPassword,hintText:"Enter your password",obscureText: authProvider.loginIsShowText,tralingIcon: authProvider.loginIsShowText? "assets/icons/Eye.svg"  : "assets/icons/Eyeopen.svg" ,errorType: "Password",trallingOntap: () {
                      authProvider.updateLoginIsShow();
                    },),
                    sizeHeight(height: 16,context: context),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, ForgotPassword.forgotPasswordRoute);
                            },
                            child: Text("Forgot password?",style: TextStyles.subTitle,))
                      ],
                    ),
                    sizeHeight(height: 30,context: context),
                    Row(
                      children: [
                        Expanded(child: mainButton(title: "Log in",onTap: () async{
                          final isValid = _formKey.currentState!.validate();
                          // if (isValid) {
                          //   Navigator.pushNamedAndRemoveUntil(context, BottomNavScreen.bottomNavRoute, (route) => false);
                          //   return;
                          // }
                          // _formKey.currentState!.save();

                           _formKey.currentState!.save();
                             bool res= await authProvider.singinUser(context);
                              if(res){
                                Navigator.pushNamedAndRemoveUntil(context, BottomNavScreen.bottomNavRoute, (route) => false);
                              }

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
                         TextSpan(text: "Don’t have an account? ",style: TextStyles.subTitle.copyWith(fontWeight: FontWeight.w400)),
                         TextSpan(text: "Sign up",style: TextStyles.subTitle.copyWith(color: AppColors.primaryColor,fontWeight: FontWeight.w600,),
                             recognizer: TapGestureRecognizer()..onTap=(){
                           Navigator.pushNamed(context, SingUpScreen.singUpScreenRoutes);
                         }
                         ),
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
