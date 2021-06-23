import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_app_checkque_pool/sidebar/sidebar.dart';
import 'package:get/get.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoHero(
                  photo:  "assets/cp-logo.png",
                  width: size.width * 0.5,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text("Appointments",
                style: TextStyle(
                    fontSize: size.width * 0.07,
                    color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/totalAppointments.png',),height: size.height * 0.06,),
                          Text('25',
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.blue
                            ),
                          ),
                          Text('Total '),
                          Text('Appointments '),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/ownAppointments.png',),height: size.height * 0.06,),
                          Text('05',
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.blue
                            ),
                          ),
                          Text('Own '),
                          Text('Appointments '),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/newAppointments.png',),height: size.height * 0.06,),
                          Text('15',
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.blue
                            ),
                          ),
                          Text('New '),
                          Text('Appointments '),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/pendingAppointments.png',),height: size.height * 0.06,),
                          Text('10',
                            style: TextStyle(
                            fontSize: size.width * 0.07,
                            color: Colors.blue
                          ),
                          ),
                          Text('Pending '),
                          Text('Appointments '),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}
