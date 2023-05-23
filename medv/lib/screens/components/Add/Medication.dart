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
      backgroundColor: KBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Container(
            height: 23,
          ),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            onTap: () {
              getImage(ImageSource.gallery);
            },
            child: Container(
              width: 340,
              height: 270,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  ImageIcon(AssetImage("assets/icons/Camera.png"),
                      size: 80, color: Colors.black),
                  Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ],
              ),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                  ]),
            ),
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            onTap: () {
              getImage(ImageSource.camera);
            },
            child: Container(
              width: 340,
              height: 270,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  ImageIcon(AssetImage("assets/icons/Gallery.png"),
                      size: 80, color: Colors.black),
                  Text(
                    "Camera",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer()
                ],
              ),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                  ]),
            ),
          ),
          Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.only(top: 50, right: 3),
          //       child: ElevatedButton(
          //         child: Text(
          //           'Light',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             darkMode = false;
          //           });
          //         },
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(top: 50, left: 3),
          //       child: ElevatedButton(
          //         child: Text(
          //           'Dark',
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         onPressed: () {
          //           setState(() {
          //             darkMode = true;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
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
