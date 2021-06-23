import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/login/login_controller.dart';
import 'package:get/get.dart';

import 'create_an_account/creat an account.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();


  var emailKey = GlobalKey<FormState>();
  var passwordKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool secureText = true;
  bool showSpinner = false;

  final  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return Scaffold(
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
                Color(0xff0093E9)
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoHero(
                  photo:  "assets/cp-logo.png",
                  width: size.width * 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Form(
                  key: loginController.emailKey,
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
                       return LoginController().validateEmail(value);
                      },
                      controller:loginController.emailController,
                      onSaved: (value){
                        loginController.email = value;
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
                        suffix: Text('User ID'),
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
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Form(
                  key: loginController.passwordKey,
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
                      controller: LoginController().passwordController,
                      validator: (String value){
                        return loginController.validatePassword(value);
                      },
                      obscureText: false,
                      onSaved: (value){
                       loginController.password = value;
                      },
                      autofocus: true,
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () async {
                              Get.to(CreateAnAccount());
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: size.width* 0.02,
                                color: Colors.white,
                              ),
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
                              loginController.checkLogin();
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
                              'Log In',
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (){}, child: Text(
                              'Forget Password',style: TextStyle(color: Colors.black),
                          ),),
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
