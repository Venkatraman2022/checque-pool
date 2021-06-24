import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';

import 'create_controller.dart';

class CreateAnAccount extends StatefulWidget {
  @override
  _CreateAnAccountState createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  bool secureText = true;


   FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return Scaffold(resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end:
              Alignment(5.0, 2.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff80D0C7),
                Color(0xff0093E9),
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: PhotoHero(
                        photo:  "assets/cp-logo.png",
                        width: size.width * 0.4,
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Create an Account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: size.width * 0.06),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.nameKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.nameController,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Full Name\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Full Name'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.doctorIDKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.doctorIDController,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Doctor ID\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Doctor ID'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.hospitalKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.hospitalController,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Hospital\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Hospital'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.clinicKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.clinicController,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Clinic\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Clinic'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.phoneNumKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          validator: (String value){
                            return createController.validatePhoneNum(value);
                          },
                          controller:createController.phoneNumController,
                          onSaved: (value){
                            createController.phoneNumber = value;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Contact Number\*',
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Contact Number'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.emailKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          validator: (String value){
                            return createController.validateEmail(value);
                          },
                          controller:createController.mailController,
                          onSaved: (value){
                            createController.email = value;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Email\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Email'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.passKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.passController,
                          validator: (String value){
                            return createController.validatePassword(value);
                          },
                          obscureText: secureText,
                          onSaved: (value){
                            createController.password = value;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Password\*" ,
                              hintStyle: TextStyle(
                                fontSize: size.width* 0.04,
                                color: Colors.blue,
                              ),
                              suffixText: 'Password',
                              suffixStyle: TextStyle(
                                fontSize: size.width* 0.03,
                                color:Colors.blue,
                              ),
                              focusColor: Colors.white),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.confirmPassKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.confirmPassController,
                          validator: (String value){
                            return createController.validateConfirmPassword(value);
                          },
                          obscureText: secureText,
                          onSaved: (value){
                            createController.confirmPassword = value;
                          },
                          autofocus: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "ConfirmPassword\*" ,
                              hintStyle: TextStyle(
                                fontSize: size.width* 0.04,
                                color: Colors.blue,
                              ),
                              suffixText: 'ConfirmPassword',
                              suffixStyle: TextStyle(
                                fontSize: size.width* 0.03,
                                color:Colors.blue,
                              ),
                              focusColor: Colors.white),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.specialisedKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.specialisedController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Specialised\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Specialised'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 10),
                    child: Form(
                      key: createController.locationKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(new Radius.circular(25.0))),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(), //
                          controller: createController.locationController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Location\*",
                            hintStyle: TextStyle(
                              fontSize: size.width* 0.04,
                              color:Colors.blue,
                            ),
                            suffix: Text('Location'),
                            suffixStyle: TextStyle(
                              fontSize: size.width* 0.03,
                              color:Colors.blue,
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                      child: MaterialButton(
                        onPressed: () async {
                          createController.checkLogin();
                          // setState(() {
                          //   showSpinner = true;
                          // });
                          // try {
                          //   print(emailController.text);
                          //   print(passwordController.text);
                          //   await _auth
                          //       .signInWithEmailAndPassword(
                          //     email: emailController.text, password:passwordController.text, )
                          //       .then((signedInUser) async{
                          //     // Navigator.pushReplacementNamed(context, 'SP');
                          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SidebarPage()));
                          //   }).catchError((e) {
                          //     print(e);
                          //     var snackbar = SnackBar(
                          //         content: Text(
                          //             'Email ID and password is incorrect please check the user name and password....'));
                          //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          //   }); //Go to login screen.
                          //
                          //   setState(() {
                          //     showSpinner = false;
                          //     emailKey.currentState.validate();
                          //     passwordKey.currentState.validate();
                          //     // nameKey.currentState.validate();
                          //     passwordController.clear();
                          //   });
                          // } catch (e) {
                          //   print(e);
                          // }
                          // passwordController.clear();
                        },
                        minWidth: 120,
                        height: 42.0,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: size.width* 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
