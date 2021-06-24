import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PrescriptionController extends GetxController {
  static PrescriptionController instance = Get.find();
  String imageUrl;
  String check;
getData(){
  var snap = FirebaseFirestore.instance
      .collection('hospital')
      .doc('doctorDetails')
      .collection('doctorDetails')
      .doc('FirebaseAuth.instance.currentUser.displayName')
      .get().then((value) =>{
  check = value['doctorName'],
  });
}
  var imageName = 'demo';
  var pdfName = 'demo';
  TextEditingController
  prescriptionSubjectController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    prescriptionSubjectController = TextEditingController();
getData();
    StreamBuilder(
        stream:FirebaseFirestore.instance
            .collection('hospital')
            .doc('doctorDetails')
            .collection('doctorDetails')
            .doc('FirebaseAuth.instance.currentUser.displayName')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return Center(
              child: SpinKitCircle(
                color: Colors.green,
              ),
            );
          }
    else
      {
        print(snapshot.data['doctorName']);

        update();
        return
            Container();
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
            .child('Hospital/${'FirebaseAuth.instance.currentUser.displayName'} - ${imageName}')
            .putFile(file)
            .whenComplete(() => print('done'));

        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        imageUrl = downloadUrl;
        update();
        print(imageUrl);
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }
  Future<void> createPDF() async {
    //Creates a new PDF document
    PdfDocument document = PdfDocument();

//Adds page settings
    document.pageSettings.orientation = PdfPageOrientation.landscape;
    document.pageSettings.margins.all = 50;

//Adds a page to the document
    PdfPage page = document.pages.add();
    PdfPage page2 = document.pages.add();
    PdfGraphics graphics = page.graphics;
    PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    Rect bounds = Rect.fromLTWH(0, 160, graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
    graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
    PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);
    page.graphics.drawString('Hospital Name!',
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(
        PdfBitmap(await _readImageData('doctorSignature.png',),),
        Rect.fromLTWH(0, 400, 200, 200));
//Creates a text element to add the invoice number
    PdfTextElement element =
    PdfTextElement(text: 'Hospital Name /Doctor Name', font: subHeadingFont);
    element.brush = PdfBrushes.white;

//Draws the heading on the page
    PdfLayoutResult result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0));
    String currentDate = 'DATE ' + DateFormat.yMMMd().format(DateTime.now());

//Measures the width of the text to place it in the correct location
    Size textSize = subHeadingFont.measureString(currentDate);
    Offset textPosition = Offset(
        graphics.clientSize.width - textSize.width - 10, result.bounds.top);

//Draws the date by using drawString method
    graphics.drawString(currentDate, subHeadingFont,
        brush: element.brush,
        bounds: Offset(graphics.clientSize.width - textSize.width - 10,
            result.bounds.top) &
        Size(textSize.width + 2, 20));

//Creates text elements to add the address and draw it to the page
    element = PdfTextElement(
        text: 'E-Prescription ',
        font: PdfStandardFont(PdfFontFamily.timesRoman, 10,
            style: PdfFontStyle.bold));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

    PdfFont timesRoman = PdfStandardFont(PdfFontFamily.timesRoman, 10);
    PdfFont drugsFont = PdfStandardFont(PdfFontFamily.timesRoman, 20);

    element = PdfTextElement(text: 'Patient Name', font: timesRoman);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0));

    element = PdfTextElement(
        text: 'Drugs will be Given Below ', font: drugsFont);
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0));


    // / Create a new PDF text element class and draw the flow layout text.
    final PdfLayoutResult layoutResult = PdfTextElement(
    text: prescriptionSubjectController.text,
    font: PdfStandardFont(PdfFontFamily.helvetica, 12),
    brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
    page: page2,
    bounds: Rect.fromLTWH(
    0, 0, page.getClientSize().width, page.getClientSize().height),
    format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));
// Draw the next paragraph/content.
    page2.graphics.drawLine(
    PdfPen(PdfColor(255, 0, 0)),
    Offset(0, layoutResult.bounds.bottom + 10),
    Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));

//Draws a line at the bottom of the address
    graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(graphics.clientSize.width, result.bounds.bottom + 3));



    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'check.pdf');
  }
  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final _storage = FirebaseStorage.instance;
    final path = (await getExternalStorageDirectory()).path;
    final file = File('$path/$fileName');
    final check = await file.writeAsBytes(bytes, flush: true);
    // if(path != null){
    //   print('filechck $file');
    //   var snapshot = await _storage.ref()
    //       .child('PDF/pdf demo')
    //       .putFile(check)
    //       .whenComplete(() => print('done'));
    //
    //   var downloadUrl = await snapshot.ref.getDownloadURL();
    //   print('downloadUrlPDF $downloadUrl');
    // }
    // else
    //   {
    //     Get.snackbar('Warning', 'Check the path');
    //     print('Check the path');
    //   }
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }
}