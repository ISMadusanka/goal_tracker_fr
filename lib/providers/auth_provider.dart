import 'package:flutter/cupertino.dart';
import 'package:habittracker/services/api_service.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier{
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();


  TextEditingController forgotEmail = TextEditingController();


  TextEditingController singUpEmail = TextEditingController();
  TextEditingController singUpPassword = TextEditingController();
  TextEditingController singUpName = TextEditingController();
  TextEditingController singUpNumber = TextEditingController();




  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  bool loginIsShowText = true;


  final AuthService _authService = AuthService();

  Future<bool> singinUser(BuildContext context) async {
    try {
      final response = await _authService.signIn(
        loginEmail.text,
        loginPassword.text,
      );

      // Handle the successful login response here, e.g., navigate to the home screen
      ApiService().setToken(response['token']);
      print("response"+response.toString());
      ApiService().setUser(response["data"]["name"], response["data"]["email"], response["data"]["phone"]);
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   '/home', // Replace with your actual home screen route
      //   (route) => false,
      // );
      return true;
    } catch (e) {
      // Handle any errors, e.g., show an error message
      print("Login failed: $e");
      return false;
      // You could show an error dialog or snack bar here
    }
  }

  Future<bool> signupUser(BuildContext context) async {
    try {
      final response = await _authService.signup(
        singUpEmail.text,
        singUpPassword.text,
        singUpName.text,
        singUpNumber.text,
      );

      // Handle the successful signup response here, e.g., navigate to the home screen
       ApiService().setToken(response['token']);
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   '/home', // Replace with your actual home screen route
      //   (route) => false,
      // );
      return true;
    } catch (e) {
      // Handle any errors, e.g., show an error message
      print("Signup failed: $e");
      return false;
      // You could show an error dialog or snack bar here
    }
  }

  

  updateLoginIsShow(){
    loginIsShowText =! loginIsShowText;
    notifyListeners();
  }

  bool isShowNewPass = true;

  updateIsShowNewPass(){
    isShowNewPass =! isShowNewPass;
    notifyListeners();
  }

  bool isShowConfirmPass = true;

  updateIsShowConfirmPass(){
    isShowConfirmPass =! isShowConfirmPass;
    notifyListeners();
  }




  bool singUpIsShowText = true;

  updateSingUpIsShow(){
    singUpIsShowText =! singUpIsShowText;
    notifyListeners();
  }
}