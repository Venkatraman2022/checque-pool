import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'new_appointment_controller.dart';

class NewAppointments extends StatefulWidget {
  const NewAppointments({Key key}) : super(key: key);

  @override
  _NewAppointmentsState createState() => _NewAppointmentsState();
}

class _NewAppointmentsState extends State<NewAppointments> {
  var maskFormatterPhone = new MaskTextInputFormatter(mask: '+91 #####-#####', filter: { "#": RegExp(r'[0-9]') });
  var maskFormatterAge = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

  final  NewAppointmentController newAppointmentController = Get.put(NewAppointmentController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(3.0,
                  2.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff80D0C9),
                Color(0xff0093E9)
              ], // red to yellow
              tileMode: TileMode
                  .repeated, // repeats the gradient over the canvas
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                        Get.back();
                      }),
                      SizedBox(
                        width:  size.width * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhotoHero(
                          photo:  "assets/cp-logo.png",
                          width: size.width * 0.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(" New Appointments",
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Full Name'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z]')),],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            controller: newAppointmentController.nameController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'Name' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Email'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z]')),],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.emailAddress,
                            controller: newAppointmentController.emailController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'Email' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Age'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              maskFormatterAge],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            controller: newAppointmentController.ageController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'01/01/2021' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'contact'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              maskFormatterPhone],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            controller: newAppointmentController.phoneNumController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'9876543210' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'Problem'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp('[a-z,A-Z]')),],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            controller: newAppointmentController.problemController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'Fever' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'COUNTRY'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z,0-9,-]')),],

                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            controller: newAppointmentController.countryController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'INDIA' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'State'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z,0-9,-]')),],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            controller: newAppointmentController.stateController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'state' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(color: Colors.grey.shade400)),
                          height: size.height * 0.06,
                          width: size.width * 0.2,
                          child: Center(
                            child: Text(
                              'City'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400)),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.length < 3)
                                return " Enter at least 3 character from Customer Name";
                              else
                                return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-z,A-Z,0-9,-]')),],
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            controller: newAppointmentController.cityController,
                            onChanged: (value){
                              // itemName = value;
                            },
                            autofillHints: [AutofillHints.givenName],
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText:'City' ,
                                hintStyle: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                                hoverColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      newAppointmentController.checkAppointment();
                    },
                    child: SizedBox(
                      height: size.height * 0.04,
                      width:  size.width ,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Allocate Appointments',textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
