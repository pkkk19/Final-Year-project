import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as ml_kit;
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:medv/screens/components/Add/Reports.dart';
import '../../../components/pdfMobile.dart' if (dart.library.html) 'web.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  bool _isConverting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
  }

  Future<void> _convertImageToPdf() async {
    setState(() {
      _isConverting = true;
    });

    // Load the image from file
    final bytes = await File(imageFile!.path).readAsBytes();
    final image = PdfBitmap(bytes);

    // Create a new PDF document
    final document = PdfDocument();

    // Add a new page to the document
    final page = document.pages.add();

    // Draw the image on the page
    page.graphics.drawImage(
        image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));

    // Save the PDF document to file
    final outputFilePath = '${imageFile!.path}.pdf';
    final outputFile = File(outputFilePath);
    await outputFile.writeAsBytes(await document.save());

    setState(() {
      _isConverting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scanner"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //prints ou the scanned text

                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (scannedText != "")
                      ElevatedButton(
                          onPressed: _convertImageToPdf,
                          child: Text("create PDF")),
                  ],
                )),
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (ml_kit.TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }

    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  void PDFmaker() {
    // Get.to(() => reports(image: scannedText));
  }
}
