import 'package:flutter/material.dart';

class DoctorPanel extends StatefulWidget {
  @override
  _DoctorPanelState createState() => _DoctorPanelState();
}

class _DoctorPanelState extends State<DoctorPanel> {
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
              end:
              Alignment(3.0, 2.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff80D0C9),
                Color(0xff0093E9)
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Column(
            children: [
              Text('data')
            ],
          ),
        ),
      ),
    );
  }
}
