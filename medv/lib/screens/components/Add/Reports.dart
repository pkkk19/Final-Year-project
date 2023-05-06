import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:medv/components/utiliReport.dart';
import 'package:printing/printing.dart';
import '../../../components/pdfMobile.dart' if (dart.library.html) 'web.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class reports extends StatefulWidget {
  reports({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<reports> createState() => _reportsState();
}

class _reportsState extends State<reports> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.save), onPressed: saveAsFile)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter PDF"),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: generatePDF,
      ),
    );
  }
}

// Future<Uint8List> _readImageData(String name) async {
//   final data = await rootBundle.load('images/$name');
//   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// }
