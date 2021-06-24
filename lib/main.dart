import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details.dart';
import 'package:flutter_app_checkque_pool/appointments/prescription/prescription.dart';
import 'package:flutter_app_checkque_pool/check.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/login/login.dart';
import 'package:flutter_app_checkque_pool/profile/profile.dart';
import 'package:flutter_app_checkque_pool/profile/profile_controller.dart';
import 'package:flutter_app_checkque_pool/services/base_client.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import "package:firebase_storage/firebase_storage.dart";

import 'appointments/new_appointments/new_appointment_controller.dart';
import 'appointments/patient_details/patient_details_controller.dart';
import 'appointments/pending_appointments/pending_appointmentController.dart';
import 'appointments/pending_appointments/pending_appointments.dart';
import 'appointments/prescription/prescription_controller.dart';
import 'constants/firebase_constants.dart';
import 'login/create_an_account/create_controller.dart';
import 'login/login_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(NewAppointmentController());
    Get.put(PatientDetailsController());
    Get.put(PendingAppointments());
    Get.put(PrescriptionController());
    Get.put(ProfileController());
    Get.put(LoginController());
    Get.put(CreateController());
  });
  SharedPreferences preferences = await SharedPreferences.getInstance();
  loginController.userName.value = preferences.getString('username');
  print('Stored username: ' + loginController.userName.toString());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  const MyApp({Key key, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:
      loginController.userName == null ?   LoginPage() : TextPage(),
    );
        // TextPage(),

  }
}

class DatePicker extends StatefulWidget {
  @override
  DatePickerState createState() =>DatePickerState();
}

/// State for MyApp
class DatePickerState extends State<DatePicker> {
  String _selectedDate = '';
  String _select = '';
  String _check = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
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
      }  else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('DatePicker demo'),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Selected date: ' + _selectedDate),
                      Text('Selected date count: ' + _dateCount),
                      Text('Selected range: ' + _range),
                      Text('Selected ranges count: ' + _rangeCount),
                      Text('Selected : ' + _select)
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 80,
                  right: 0,
                  bottom: 0,
                  child: SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                )
              ],
            ),
        ),
    );
  }
}


class TextPage extends StatefulWidget {
  const TextPage({Key key}) : super(key: key);

  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: () async{
        var response = await BaseClient().get('https://jsonplaceholder.typicode.com', '/todos/1');
        // print(response['title']);
      }, child: Center(child: Text('Test')),
    )
    );
  }
}

