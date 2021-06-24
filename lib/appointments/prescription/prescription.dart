import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'prescription_controller.dart';

class Prescription extends StatefulWidget {
  const Prescription({Key key}) : super(key: key);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {

  String check;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(
                  3.0, 2.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff80D0C9),
                Color(0xff0093E9)
              ], // red to yellow
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: StreamBuilder(
              stream:FirebaseFirestore.instance
                  .collection('hospital')
                  .doc('doctorDetails')
                  .collection('doctorDetails')
                  .doc(FirebaseAuth.instance.currentUser.displayName)
                  .snapshots(),
            builder:  (context, snapshot)  {
              if (!snapshot.hasData || snapshot.hasError) {
                return Center(
                  child: SpinKitCircle(
                    color: Colors.green,
                  ),
                );
              }
              check = snapshot.data['doctorName'];
              return SingleChildScrollView(
                child: GetBuilder<PrescriptionController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: PhotoHero(
                            photo: "assets/cp-logo.png",
                            width: size.width * 0.3,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "E - Prescription",
                              style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                prescriptionController.uploadImage();
                                print('img check ${prescriptionController.imageUrl}');
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.yellow,
                                radius: 20,
                                child: Icon(
                                  Icons.attach_file_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                    controller.imageUrl == null ?     Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: size.height * 0.2,
                            width: size.width,
                            child: Card(
                              child: TextField(
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(), //
                                maxLines: null,
                                expands: true,
                                controller: controller.prescriptionSubjectController,
                                keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText:'E- Prescription Subject' ,
                                      hintStyle: TextStyle(
                                        color: Colors.blue,
                                        fontStyle: FontStyle.italic,
                                        fontSize: size.width * 0.03,
                                      ),
                                      hoverColor: Colors.white,
                                      filled: true,
                                      focusColor: Colors.white)
                              ),
                            ),
                          ),
                        ) : SizedBox(
                      height: size.height * 0.2,
                      width: size.width,
                          child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(prescriptionController.imageUrl,scale: 1,),
                    ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            if(controller.imageUrl == null){
                              setState(() {
                                controller.createPDF();
                                // Get.to( PDF().cachedFromUrl(
                                //   'https://firebasestorage.googleapis.com/v0/b/checque-pool.appspot.com/o/PDF%2Fpdf%20demo?alt=media&token=6d65031c-e2e9-4eff-9f85-dc1da9c37623',
                                //   placeholder: (progress) => Center(child: Text('$progress %')),
                                //   errorWidget: (error) => Center(child: Text(error.toString())),
                                // ));
                                print('Create Prescription');
                              });
                            }
                            else
                              {
                                print('Send Prescription');
                              }
                          },
                          child: Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                               controller.imageUrl == null ?  'Create Prescription' : 'Send Prescription',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(check == null ? 'Check' : check),

                      ],
                    );
                  }
                ),
              );
            }
          ),
        ),
      ),
    );
  }

}
