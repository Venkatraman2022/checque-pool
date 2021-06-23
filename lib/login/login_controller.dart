import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/chat/chat_screen.dart';
import 'package:flutter_app_checkque_pool/login/create_an_account/creat%20an%20account.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
   TextEditingController emailController,passwordController;
   var email = '';
   var password = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   emailController.dispose();
  //   passwordController.dispose();
  // }

  String validateEmail(String value){
    if(!GetUtils.isEmail(value))
      {
        return ' Provide Correct Email';
      }
    return null;
  }

  String validatePassword(String value){
    password = value;
    if(value.length < 6)
    {
      return ' Password must be 6 character';
    }
    return null;
  }

  void checkLogin() async {
    final isEmail = emailKey.currentState.validate();
   final isPass=  passwordKey.currentState.validate();

   if(!isEmail && !isPass )
     {
       Get.snackbar('Warning', 'Please Fill the Email and Password',backgroundColor: Colors.red ,colorText: Colors.white);
     }
   else if(emailController.text != '' && password != null){
    CircularProgressIndicator();
    print(password);
    await _auth
        .signInWithEmailAndPassword(
      email: emailController.text, password:password, ).then((value) {
      Get.to(ChatScreen());
    }).catchError((onError){
      Get.snackbar('Warning', 'Please Check Your Email ID and Password',backgroundColor: Colors.red ,colorText: Colors.white);
      print(emailController.text);
      print(password);
      print(onError);
    });
   }
   else
     {
       Get.snackbar('Warning', '.....');
     }
    return;
  }
}