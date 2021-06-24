import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:get/get.dart';

class PatientDetailsController extends GetxController {
  static PatientDetailsController instance = Get.find();
  final _auth = FirebaseAuth.instance;
  TextEditingController
  nameController,
      emailController,
      ageController,
      phoneNumController,
      problemController,
      countryController,
      stateController,
      cityController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    nameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
    phoneNumController = TextEditingController();
    problemController = TextEditingController();
    countryController = TextEditingController();
    stateController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }






  void checkAppointment() async{

    if (nameController.text == '' &&
        ageController.text == '' &&
        emailController.text == '' &&
        phoneNumController.text == ''
        && cityController.text == ''  && stateController.text == '' && countryController.text == '' && problemController.text == '') {
      Get.snackbar('Warning', 'Please Fill all Fields',backgroundColor: Colors.red ,colorText: Colors.white);
    } else  {
      // Get.to(CreateAnAccount());
      // await _auth.createUserWithEmailAndPassword(email: mailController.text, password: passController.text,).then((SignedInUser) async{
      //   await FirebaseFirestore.instance
      //       .collection('hospital')
      //       .doc("doctorDetails").collection('doctorDetails').doc(phoneNumController.text)
      //       .set({
      //     'email' : FirebaseAuth.instance.currentUser.email,
      //     'uid' : FirebaseAuth.instance.currentUser.uid,
      //     'doctorName' : nameController.text ,
      //     'password' : passController.text,
      //     'doctorID' :doctorIDController.text,
      //     'specializedIn': specialisedController.text,
      //     'clinic': clinicController.text,
      //     'hospitalName': hospitalController.text,
      //     'phoneNumber': phoneNumController.text,
      //     'location': locationController.text,
      //     'availableDates' : '',
      //   }).then((value) {
      //     SignedInUser.user.updateProfile(displayName: phoneNumController.text);
      //     Get.to(ProfilePage());
      //   });
      // });
      print('everything updated');
    }
    return;
  }
}
