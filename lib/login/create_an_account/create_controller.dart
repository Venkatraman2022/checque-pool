import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  static CreateController instance = Get.find();
  var nameKey = GlobalKey<FormState>();
  var doctorIDKey = GlobalKey<FormState>();
  var phoneNumKey = GlobalKey<FormState>();
  var emailKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormState>();
  var confirmPassKey = GlobalKey<FormState>();
  var specialisedKey = GlobalKey<FormState>();
  var locationKey = GlobalKey<FormState>();
  var clinicKey = GlobalKey<FormState>();
  var hospitalKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController,
      doctorIDController,
      phoneNumController,
      passController,
      mailController,
      confirmPassController,
      specialisedController,
      clinicController,
      hospitalController,
      locationController;
  var email = '';
  var password = '';
  var confirmPassword = '';
  var phoneNumber = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    nameController = TextEditingController();
    doctorIDController = TextEditingController();
    phoneNumController = TextEditingController();
    mailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    specialisedController = TextEditingController();
    locationController = TextEditingController();
    hospitalController = TextEditingController();
    clinicController = TextEditingController();
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
  //   mailController.dispose();
  //   passController.dispose();
  //   phoneNumController.dispose();
  //   doctorIDController.dispose();
  //   specialisedController.dispose();
  //   confirmPassController.dispose();
  //   locationController.dispose();
  //   nameController.dispose();
  //   clinicController.dispose();
  //   locationController.dispose();
  // }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return ' Provide Correct Email';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return ' Password must be 6 character';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.length < 6) {
      return ' Password must be 6 character';
    }

    if (value.length > 6) {
      if (passController.text != confirmPassController.text) {
        return ' Password and Confirm Password Does not Match';
      }
    }
    return null;
  }

  String validatePhoneNum(String value) {
    if (value.length < 10) {
      return ' Phone Number must have 10 Numbers';
    }
    return null;
  }

  void checkLogin() async{
    final isNum = phoneNumKey.currentState.validate();
    final isEmail = emailKey.currentState.validate();
    final isPass = passKey.currentState.validate();
    final isConfirmPass = confirmPassKey.currentState.validate();

    if (!isEmail && !isPass && !isNum && !isConfirmPass) {
      Get.snackbar('Warning', 'Please Fill all Fields');
    } else if (nameController.text == '' &&
        doctorIDController.text == '' &&
        specialisedController.text == '' &&
        locationController.text == ''
     && clinicController.text == ''  && hospitalController.text == '') {
      Get.snackbar('Warning', 'Please Fill all Fields',backgroundColor: Colors.red ,colorText: Colors.white);
    } else  {
      // Get.to(CreateAnAccount());
     await _auth.createUserWithEmailAndPassword(email: mailController.text, password: passController.text,).then((SignedInUser) async{
       await FirebaseFirestore.instance
           .collection('hospital')
           .doc("doctorDetails").collection('doctorDetails').doc(phoneNumController.text)
           .set({
         'email' : FirebaseAuth.instance.currentUser.email,
         'uid' : FirebaseAuth.instance.currentUser.uid,
         'doctorName' : nameController.text ,
         'password' : passController.text,
         'doctorID' :doctorIDController.text,
         'specializedIn': specialisedController.text,
         'clinic': clinicController.text,
         'hospitalName': hospitalController.text,
         'phoneNumber': phoneNumController.text,
         'location': locationController.text,
         'availableDates' : '',
       }).then((value) {
         SignedInUser.user.updateProfile(displayName: phoneNumController.text);
         Get.to(ProfilePage());
       });
     });
    }
    return;
  }
}
