import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/profile/profile_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool autofocus = false;
  // var authPhone = FirebaseAuth.instance.currentUser.displayName;
  var docID;
  String imageUrl ='https://image.shutterstock.com/image-vector/default-placeholder-doctor-halflength-portrait-260nw-1061744402.jpg';

  TextEditingController _timeControllerFM = TextEditingController();
  TextEditingController _timeControllerTO = TextEditingController();
  String _hour, _minute, _time;

  String dateTime;
var demo;
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);


  String _selectedDate = '';
  String _select = '';
  String _check = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  List<DateTime> initialSelectedDates = [];
  List time = [];
var imageName;
var  check;
var data;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    initialSelectedDates.clear();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialSelectedDates.clear();
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectTimeFM(BuildContext context, StateSetter setstate) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null)
        setstate(() {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          _timeControllerFM.text = _time;
          _timeControllerFM.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn, " ", am]).toString();
        });
    }

    Future<Null> _selectTimeTO(BuildContext context, StateSetter setstate) async {
      final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null)
        setstate(() {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + _minute;
          _timeControllerTO.text = _time;
          _timeControllerTO.text = formatDate(
              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
              [hh, ':', nn, " ", am]).toString();
        });
    }

    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('hospital')
            .doc('doctorDetails')
            .collection('doctorDetails')
            .doc('authPhone')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: SpinKitCircle(
                color: Colors.green,
              ),
            );
          } else {
            imageName = snapshot.data['doctorName'];
            docID = snapshot.data.id;
            // time.add(snapshot.data['availableDates']);
            check = snapshot.data['availableDates'] == null ? 'no dates': snapshot.data['availableDates'];
            check.forEach((element) {
              // initialSelectedDates.add(DateTime.fromMicrosecondsSinceEpoch(element.microsecondsSinceEpoch) );

              demo = DateTime.fromMicrosecondsSinceEpoch(element.microsecondsSinceEpoch);
              initialSelectedDates.add(demo);

              print( 'date time ${DateTime.fromMicrosecondsSinceEpoch(element.microsecondsSinceEpoch)}');
              print(initialSelectedDates);

            });
            // print('ii $check');
            // print('tt $time');
            return StatefulBuilder(builder: (context, StateSetter showState) {
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
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 30),
                                            child: InkWell(
                                              onTap: (){
                                                uploadImage();
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50.0),
                                                child: Image.network( FirebaseAuth.instance.currentUser.photoURL == null ?
                                                imageUrl :
                                                FirebaseAuth.instance.currentUser.photoURL,scale: 1,),

                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: profileController
                                                        .autofocusName ==
                                                    true
                                                ? TextFormField(
                                              textInputAction: TextInputAction.next,
                                              onEditingComplete: () => node.nextFocus(), //
                                                    controller: profileController
                                                        .nameController,
                                                    autofocus: profileController
                                                        .autofocusName,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      errorBorder: InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      hintText: "Name\*",
                                                      hintStyle: TextStyle(
                                                        fontSize: size.width * 0.04,
                                                        color: Colors.blue,
                                                      ),
                                                      suffixStyle: TextStyle(
                                                        fontSize: size.width * 0.03,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : Text(snapshot.data['doctorName']),
                                            subtitle:
                                                Text(snapshot.data['location']),
                                            trailing: IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  showState(() {
                                                    profileController
                                                        .autofocusName = true;
                                                    profileController.saveButton =
                                                        true;
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController.autofocusPhone ==
                                                  true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                                  controller: profileController
                                                      .phoneNumController,
                                                  autofocus: profileController
                                                      .autofocusPhone,
                                                  keyboardType: TextInputType.name,
                                                  decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: "Phone\*",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width * 0.04,
                                                      color: Colors.blue,
                                                    ),
                                                    suffixStyle: TextStyle(
                                                      fontSize: size.width * 0.03,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              : Text(snapshot.data['phoneNumber']),
                                          subtitle: Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.phone),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController.autofocusPhone =
                                                      true;
                                                  profileController.saveButton =
                                                      true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController
                                              .autofocusDoctorID ==
                                              true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                            controller: profileController
                                                .doctorIDController,
                                            autofocus: profileController
                                                .autofocusDoctorID,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder:
                                              InputBorder.none,
                                              hintText: "doctorID\*",
                                              hintStyle: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.blue,
                                              ),
                                              suffixStyle: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.black),
                                          )
                                              : Text(snapshot.data['doctorID']),
                                          subtitle: Text(
                                            'doctorID',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.local_hospital),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController
                                                      .autofocusDoctorID = true;
                                                  profileController.saveButton =
                                                  true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController.autofocusEmail ==
                                              true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                            controller: profileController
                                                .emailController,
                                            autofocus: profileController
                                                .autofocusEmail,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder:
                                              InputBorder.none,
                                              hintText: "email\*",
                                              hintStyle: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.blue,
                                              ),
                                              suffixStyle: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.black),
                                          )
                                              : Text(snapshot.data['email']),
                                          subtitle: Text(
                                            'email',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.security),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController.autofocusEmail =
                                                  true;
                                                  profileController.saveButton =
                                                  true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController.autofocusPass ==
                                                  true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                                  controller: profileController
                                                      .passController,
                                                  autofocus: profileController
                                                      .autofocusPass,
                                                  keyboardType: TextInputType.name,
                                                  decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: "Password\*",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width * 0.04,
                                                      color: Colors.blue,
                                                    ),
                                                    suffixStyle: TextStyle(
                                                      fontSize: size.width * 0.03,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              : Text(snapshot.data['password']),
                                          subtitle: Text(
                                            'Password',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.security),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController.autofocusPass =
                                                      true;
                                                  profileController.saveButton =
                                                      true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController
                                                      .autofocusHospital ==
                                                  true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                                  controller: profileController
                                                      .hospitalController,
                                                  autofocus: profileController
                                                      .autofocusHospital,
                                                  keyboardType: TextInputType.name,
                                                  decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: "Hospital\*",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width * 0.04,
                                                      color: Colors.blue,
                                                    ),
                                                    suffixStyle: TextStyle(
                                                      fontSize: size.width * 0.03,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              : Text(snapshot.data['hospitalName']),
                                          subtitle: Text(
                                            'Hospital',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.local_hospital),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController
                                                      .autofocusHospital = true;
                                                  profileController.saveButton =
                                                      true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController
                                                      .autofocusClinic ==
                                                  true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                                  controller: profileController
                                                      .clinicController,
                                                  autofocus: profileController
                                                      .autofocusClinic,
                                                  keyboardType: TextInputType.name,
                                                  decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    hintText: "Clinic\*",
                                                    hintStyle: TextStyle(
                                                      fontSize: size.width * 0.04,
                                                      color: Colors.blue,
                                                    ),
                                                    suffixStyle: TextStyle(
                                                      fontSize: size.width * 0.03,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              : Text(snapshot.data['clinic']),
                                          subtitle: Text(
                                            'Clinic',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.local_hospital),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController
                                                      .autofocusClinic = true;
                                                  profileController.saveButton =
                                                      true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: profileController
                                              .autofocusSpecializedIn ==
                                              true
                                              ? TextFormField(
                                            textInputAction: TextInputAction.next,
                                            onEditingComplete: () => node.nextFocus(), //
                                            controller: profileController
                                                .specialisedController,
                                            autofocus: profileController
                                                .autofocusSpecializedIn,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder:
                                              InputBorder.none,
                                              hintText: "specializedIn\*",
                                              hintStyle: TextStyle(
                                                fontSize: size.width * 0.04,
                                                color: Colors.blue,
                                              ),
                                              suffixStyle: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.black),
                                          )
                                              : Text(snapshot.data['specializedIn']),
                                          subtitle: Text(
                                            'specializedIn',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.local_hospital),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showState(() {
                                                  profileController
                                                      .autofocusSpecializedIn = true;
                                                  profileController.saveButton =
                                                  true;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: size.height * 0.09,
                                        padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(25.0))),
                                        child: ListTile(
                                          title: Text('Appointments'),
                                          subtitle: Text(
                                            'Doctor Appointments',
                                            style: TextStyle(
                                                fontSize: size.width * 0.03),
                                          ),
                                          leading: Icon(Icons.calendar_today),
                                          trailing: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {

                                                showState(() {
                                                  print('initobs $initialSelectedDates');
                                                  Get.defaultDialog(
                                                    title: 'Appointments',
                                                    content: StatefulBuilder(
                                                      builder: (context, StateSetter setstate) {
                                                        return Column(
                                                          children: [
                                                            SfDateRangePicker(
                                                              onSelectionChanged: _onSelectionChanged,
                                                              selectionMode: DateRangePickerSelectionMode.multiple,
                                                              initialSelectedRange: PickerDateRange(
                                                                  DateTime.now().subtract(const Duration(days: 4)),
                                                                  DateTime.now().add(const Duration(days: 3))),
                                                              initialSelectedDates: initialSelectedDates,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    _selectTimeFM(context,setstate );
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(width: size.width * .005),
                                                                      Text(
                                                                        'FM-',
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      ),
                                                                      SizedBox(width: size.width * .01),
                                                                      _timeControllerFM.text == ''
                                                                          ? Text(
                                                                        ' Time',
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      )
                                                                          : Text(
                                                                        _timeControllerFM.text,
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      ),
                                                                      SizedBox(width: size.width * .005),
                                                                      Text(
                                                                        '--',
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    _selectTimeTO(context,setstate );
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(width: size.width * .005),
                                                                      Text(
                                                                        'TO --',
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      ),
                                                                      SizedBox(width: size.width * .01),
                                                                      _timeControllerTO.text == ''
                                                                          ? Text(
                                                                        ' Time',
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      )
                                                                          : Text(
                                                                        _timeControllerTO.text,
                                                                        style: TextStyle(
                                                                            fontSize: size.width * 0.05),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                             Row(
                                                               mainAxisAlignment: MainAxisAlignment.end,
                                                               children: [
                                                                 TextButton(onPressed: (){
                                                                   Get.back();
                                                                 }, child: Text('Cancel')),

                                                                 TextButton(onPressed: ()async{
                                                                  print('i$initialSelectedDates');
                                                                 if(_timeControllerFM.text !='' && _timeControllerTO.text != ''){
                                                                   for(int i = 0; i<initialSelectedDates.length; i++){
                                                                     time.add('${_timeControllerFM.text} - ${_timeControllerTO.text}');
                                                                     print('time $time');
                                                                   }
                                                                 }
                                                                  if(time.length !=0 ){
                                                                    await FirebaseFirestore.instance
                                                                        .collection('hospital')
                                                                        .doc("doctorDetails")
                                                                        .collection(
                                                                        'doctorDetails')
                                                                        .doc(docID)
                                                                        .set({
                                                                      'email': FirebaseAuth
                                                                          .instance
                                                                          .currentUser
                                                                          .email,
                                                                      'uid': FirebaseAuth.instance
                                                                          .currentUser.uid,
                                                                      'doctorName':
                                                                      profileController
                                                                          .nameController
                                                                          .text == ''? snapshot.data['doctorName']:  profileController
                                                                          .nameController
                                                                          .text,
                                                                      'password':
                                                                      profileController
                                                                          .passController
                                                                          .text == '' ? snapshot.data['password']:
                                                                      profileController
                                                                          .passController
                                                                          .text,
                                                                      'doctorID':
                                                                      profileController
                                                                          .doctorIDController
                                                                          .text == '' ? snapshot.data['doctorID']:
                                                                      profileController
                                                                          .doctorIDController
                                                                          .text ,
                                                                      'specializedIn':
                                                                      profileController
                                                                          .specialisedController
                                                                          .text == '' ?snapshot.data['specializedIn'] : profileController
                                                                          .specialisedController
                                                                          .text,
                                                                      'clinic': profileController
                                                                          .clinicController.text == '' ?snapshot.data['clinic'] : profileController
                                                                          .clinicController.text,
                                                                      'hospitalName':
                                                                      profileController
                                                                          .hospitalController
                                                                          .text == ''?snapshot.data['hospitalName'] : profileController
                                                                          .hospitalController
                                                                          .text,
                                                                      'phoneNumber':
                                                                      profileController
                                                                          .phoneNumController
                                                                          .text == ''? snapshot.data['phoneNumber']: profileController
                                                                          .phoneNumController
                                                                          .text,
                                                                      'location':
                                                                      profileController
                                                                          .locationController
                                                                          .text == '' ? snapshot.data['location']:   profileController
                                                                          .locationController
                                                                          .text,
                                                                      'availableDates': initialSelectedDates.toList(),
                                                                      'availableTIme': time,
                                                                    }).then((value) {
                                                                      initialSelectedDates.clear();
                                                                      time.clear();
                                                                      Get.back();
                                                                    });
                                                                  }
                                                                  else
                                                                    {
                                                                      Get.snackbar('Warning',  'Please fill the Time',backgroundColor: Colors.red ,colorText: Colors.white);
                                                                    }


                                                            }, child: Text('Save')),
                                                               ],
                                                             ),

                                                          ],
                                                        );
                                                      }
                                                    )
                                                  );
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    profileController.saveButton == true
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Material(
                                              elevation: 5.0,
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: MaterialButton(
                                                onPressed: () async {
                                                  setState(() {

                                                    if (profileController
                                                                .nameController
                                                                .text ==
                                                            '' &&
                                                        profileController
                                                            .emailController
                                                            .text ==
                                                            '' &&
                                                        profileController
                                                                .doctorIDController
                                                                .text ==
                                                            '' &&
                                                        profileController
                                                                .specialisedController
                                                                .text ==
                                                            '' &&
                                                        profileController
                                                                .locationController
                                                                .text ==
                                                            '' &&
                                                        profileController
                                                                .clinicController.text ==
                                                            '' &&
                                                        profileController
                                                                .hospitalController.text ==
                                                            '' &&
                                                        profileController
                                                                .passController
                                                                .text ==
                                                            '' &&
                                                        profileController
                                                                .phoneNumController
                                                                .text ==
                                                            '') {
                                                      Get.snackbar('Warning',
                                                          'Please Fill all Fields');
                                                    } else {
                                                      // Get.to(CreateAnAccount());
                                                      profileController.passController.text != '' ?    FirebaseAuth.instance.currentUser.updatePassword(profileController.passController.text): print('password error');
                                                      profileController.emailController.text != '' ? FirebaseAuth.instance.currentUser.updateEmail(profileController.emailController.text) : print('email error');
                                                      FirebaseFirestore.instance
                                                          .collection('hospital')
                                                          .doc("doctorDetails")
                                                          .collection(
                                                              'doctorDetails')
                                                          .doc(docID)
                                                          .set({
                                                        'email': FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .email,
                                                        'uid': FirebaseAuth.instance
                                                            .currentUser.uid,
                                                        'doctorName':
                                                            profileController
                                                                .nameController
                                                                .text == ''? snapshot.data['doctorName']:  profileController
                                                          .nameController
                                                          .text,
                                                        'password':
                                                            profileController
                                                                .passController
                                                                .text == '' ? snapshot.data['password']:
                                                      profileController
                                                          .passController
                                                          .text,
                                                        'doctorID':
                                                            profileController
                                                                .doctorIDController
                                                                .text == '' ? snapshot.data['doctorID']:
                                                      profileController
                                                          .doctorIDController
                                                          .text ,
                                                        'specializedIn':
                                                            profileController
                                                                .specialisedController
                                                                .text == '' ?snapshot.data['specializedIn'] : profileController
                                                          .specialisedController
                                                          .text,
                                                        'clinic': profileController
                                                            .clinicController.text == '' ?snapshot.data['clinic'] : profileController
                                                          .clinicController.text,
                                                        'hospitalName':
                                                            profileController
                                                                .hospitalController
                                                                .text == ''?snapshot.data['hospitalName'] : profileController
                                                          .hospitalController
                                                          .text,
                                                        'phoneNumber':
                                                            profileController
                                                                .phoneNumController
                                                                .text == ''? snapshot.data['phoneNumber']: profileController
                                                          .phoneNumController
                                                          .text,
                                                        'location':
                                                            profileController
                                                                .locationController
                                                                .text == '' ? snapshot.data['location']:   profileController
                                                          .locationController
                                                          .text,
                                                      });
                                                      profileController.saveButton =
                                                          false;
                                                      profileController
                                                          .autofocusPass = false;
                                                      profileController
                                                          .autofocusClinic = false;
                                                      profileController
                                                              .autofocusHospital =
                                                          false;
                                                      profileController
                                                          .autofocusPhone = false;
                                                      profileController
                                                          .autofocusName = false;
                                                      profileController.autofocusSpecializedIn = false;
                                                      profileController.autofocusDoctorID =false;
                                                      profileController.autofocusEmail = false;
                                                    }
                                                    return;
                                                  });
                                                },
                                                minWidth: 120,
                                                height: 42.0,
                                                child: Text(
                                                  'Log In',
                                                  style: TextStyle(
                                                    fontSize: size.width * 0.02,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          }
        });
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('Hospital/${FirebaseAuth.instance.currentUser.displayName} - ${imageName}')
            .putFile(file)
            .whenComplete(() => print('done'));

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          FirebaseAuth.instance.currentUser.updateProfile(photoURL: imageUrl);
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args, ) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {

      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      }else if (args.value is List<DateTime>) {
        _check = args.value.toString();
        _select = _check.replaceAll('00:00:00.000', '');
        print(_select);
        print(_check);
        initialSelectedDates = args.value;
        print(initialSelectedDates);
        setState(() {

        });
      }  else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

}
