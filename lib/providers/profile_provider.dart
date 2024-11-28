import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {

  List profileData =[
    {"title":"My Profile","icon":"assets/icons/Profile.svg"},
    {"title":"My habits","icon":"assets/icons/Clipboard.svg"},
    {"title":"Privacy Policy","icon":"assets/icons/Privacy.svg"},
    {"title":"Settings","icon":"assets/icons/setting.svg"},
    {"title":"Log out","icon":"assets/icons/exit.svg"},
  ];

  List settingData =[
    {"title":"Change password","icon":"assets/icons/Lock.svg"},
    {"title":"Terms & conditions","icon":"assets/icons/terms.svg"},
    {"title":"About us","icon":"assets/icons/Info.svg"},
    {"title":"Delete Account","icon":"assets/icons/trash.svg"},
  ];

  TextEditingController chanePassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confrormPassController = TextEditingController();



  TextEditingController editName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editNumber = TextEditingController();
  String ccode = "+91";


  bool changePass = true;

  XFile? proImage;

  pickImage() async{
    final ImagePicker picker = ImagePicker();
    proImage = (await picker.pickImage(source: ImageSource.camera) as XFile);
    notifyListeners();
  }

  updateChangePass(){
    changePass =! changePass;
    notifyListeners();
  }

  bool conformPass = true;

  updateConformPass(){
    conformPass =! conformPass;
    notifyListeners();
  }

  bool newPass = true;

  updateNewPass(){
    newPass =! newPass;
    notifyListeners();
  }
}
