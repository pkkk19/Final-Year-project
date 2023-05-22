import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medv/constants.dart';
import 'package:medv/screens/components/Add/saveDetails.dart';

class medication extends StatefulWidget {
  const medication({Key? key}) : super(key: key);

  @override
  State<medication> createState() => _ScannerState();
}

class _ScannerState extends State<medication> {
  List<String> medicationSuffixes = [
    "afil",
    "ane",
    "arabine",
    "arone",
    "asone",
    "azepam",
    "azine",
    "azole",
    "bactam",
    "barb",
    "caine",
    "calci",
    "ciclovir",
    "cycline",
    "dazole",
    "dipine",
    "dronate",
    "eprazole",
    "ergot",
    "fibrate",
    "gabalin",
    "gliflozin",
    "glitazone",
    "gravir",
    "ine",
    "ipramine",
    "irudin",
    "lam",
    "micin",
    "mab",
    "navir",
    "nib",
    "olol",
    "omycin",
    "oxacin",
    "parin",
    "penem",
    "phylline",
    "prazole",
    "pril",
    "prost",
    "ridone",
    "sartan",
    "semide",
    "setron",
    "sone",
    "statin",
    "tadine",
    "terol",
    "thiazide",
    "tidine",
    "trel",
    "triptan",
    "tyline",
    "vir",
    "vudine",
    "xaban",
    "zepam",
    "zoline"
  ];
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";
  String medicationName = "";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:
              kPrimaryColor, // Set the color of all icons in the app bar here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: kPrimaryColor,
            ),
        title: const Text(
          "Medication",
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (textScanning) const CircularProgressIndicator(),
              if (!textScanning && imageFile == null) Container(),
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
              Container(
                child: Text(
                  medicationName,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
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
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }

    textScanning = false;
    setState(() {});
    getMedicationName();
    Get.to(() => SaveDetails(), arguments: {'medicationName': medicationName});
  }

  void getMedicationName() {
    List<String> words = scannedText.split(RegExp(r'\s+'));
    // Find the words that end with a medication suffix
    Set<String> medicationWords = {};
    for (String word in words) {
      for (String suffix in medicationSuffixes) {
        if (word.contains(suffix)) {
          medicationWords.add(word);
          break;
        }
      }
    }
    medicationName = (medicationWords.join(', '));
  }

  @override
  void initState() {
    super.initState();
  }
}
