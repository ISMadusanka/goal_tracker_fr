import 'package:flutter/cupertino.dart';

Widget sizeHeight({context,required num height}){
  var size =  height /MediaQuery.of(context).size.height ;
  return SizedBox(height: MediaQuery.of(context).size.height * size,);
}

Widget sizeWidth({context,required num width}){
  var size =  width /MediaQuery.of(context).size.width ;
  return SizedBox(width: MediaQuery.of(context).size.width * size,);
}