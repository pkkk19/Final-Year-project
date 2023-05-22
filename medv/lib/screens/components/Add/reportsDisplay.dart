import 'dart:io';

import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medv/constants.dart';
import 'package:get/get.dart';
import 'package:medv/screens/components/Add/add.dart';
import 'package:medv/screens/components/Add/storageReports/storageService.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:medv/screens/components/Add/storageReports/userdetail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:medv/screens/components/home/User_home_test.dart';
import 'package:universal_html/js_util.dart';

class reportsDisplay extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<reportsDisplay> {
  PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;
  final Storage storage = Storage();
  final UserDetail userDetail = UserDetail();
  String Username = "";

  @override
  void initState() {
    setState(() {
      username();
    });
    super.initState();
  }

  username() async {
    Username = await userDetail.getName();
    print(Username);
  }

  openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(context,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
          ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
          ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
              "Only {PAGES_COUNT} Page"
        },
        source: ScannerFileSource.GALLERY);
    if (doc != null) {
      _scannedDocument = null;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
      _scannedDocument = await PDFDocument.fromFile(doc);
      setState(() {});
    }
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {});
      final path = _scannedImage?.path;
      final fileName = path?.split("/").last;
      storage.UploadFile(path!, fileName!, "reports", Username)
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Done!',
                  message: 'Your File has been uploaded!',

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.success,
                ),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final username = arguments['name'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color:
                kPrimaryColor, // Set the color of all icons in the app bar here
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: kPrimaryColor,
              ),
          title: const Text(
            "Reports",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Center(
              //   child: Builder(builder: (context) {
              //     return ElevatedButton(
              //         onPressed: () => openPdfScanner(context),
              //         child: Text("PDF Scan"));
              //   }),
              // ),

              FutureBuilder(
                  future: storage.listFiles(username, "reports"),
                  builder: (context,
                      AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.items.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: storage.downloadURL(
                                      username,
                                      "reports",
                                      snapshot.data!.items[index].name),
                                  builder: (context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        width: 10,
                                        height: 220,
                                        child: Image.network(
                                          snapshot.data!,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }

                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        !snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    return Container();
                                  });
                            }),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return CircularProgressIndicator();
                  }),
              Center(
                child: Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => openImageScanner(context),
                      child: Text("Image Scan"));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
