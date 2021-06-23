import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';


class PendingAppointment extends StatefulWidget {
  const PendingAppointment({Key key}) : super(key: key);

  @override
  _PendingAppointmentState createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {
  final  PendingAppointments pendingAppointmentsController = Get.put(PendingAppointments());
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: PhotoHero(
                  photo:  "assets/cp-logo.png",
                  width: size.width * 0.3,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text("Pending Appointments",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                  itemCount: pendingAppointmentsController.patientName.length,
                  itemBuilder: (BuildContext context,int index){
                return
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: InkWell(
                        onTap: (){
                          Get.to(PatientDetails());
                        },
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.perm_contact_cal_rounded),
                            title: Text(pendingAppointmentsController.patientName[index],style:  TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.normal,
                              fontSize: size.width * 0.04,
                            ),),
                            subtitle: Text(pendingAppointmentsController.patientLocation[index],style:  TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: size.width * 0.03,
                            ),),
                          ),
                        ),
                      ),
                    );
              })
            ],
          ),
        ),
      ),
    );
  }
}
