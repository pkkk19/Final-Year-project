import 'dart:io' as di;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePDF(final PdfPageFormat format) async {
  final doc = pw.Document(
    title: 'Medical Report',
  );
  final logoImage = pw.MemoryImage(
    (await rootBundle.load("assets/Logo3.png")).buffer.asUint8List(),
  );
  final footerImage = pw.MemoryImage(
    (await rootBundle.load("assets/footer.png")).buffer.asUint8List(),
  );
  final font = await rootBundle.load('assets/OpenSansRegular.ttf');
  final ttf = pw.Font.ttf(font);

  final pageTheme = await _myPageTheme(format);

  doc.addPage(pw.MultiPage(
      pageTheme: pageTheme,
      header: (final context) => pw.Image(
            alignment: pw.Alignment.topLeft,
            logoImage,
            fit: pw.BoxFit.contain,
            width: 140,
          ),
      footer: (final context) => pw.Image(
            footerImage,
            fit: pw.BoxFit.scaleDown,
          ),
      build: (final context) => [
            pw.Container(
              padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
            ),
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('phone: '),
                        pw.Text('Email: '),
                        pw.Text(
                          'Instagram: ',
                        ),
                      ]),
                  // pw.size
                ])
          ]));
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final logoImage = pw.MemoryImage(
    (await rootBundle.load('assets/Logo3.png')).buffer.asUint8List(),
  );
  return pw.PageTheme(
      margin: const pw.EdgeInsets.symmetric(
          horizontal: 1 * PdfPageFormat.cm, vertical: 0.5 * PdfPageFormat.cm),
      textDirection: pw.TextDirection.ltr,
      orientation: pw.PageOrientation.portrait,
      buildBackground: (final context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Watermark(
              angle: 20,
              child: pw.Opacity(
                  opacity: 0.5,
                  child: pw.Image(
                      alignment: pw.Alignment.center,
                      logoImage,
                      fit: pw.BoxFit.cover)))));
}

Future<void> saveAsFile(
  final BuildContext,
  final LayoutCallback,
  final PdfPageFormat,
) async {
  final bytes = await PdfPageFormat(BuildContext);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = di.File('$appDocPath/document.pdf');
  print('save as file ${file.path}...');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

void showPrintedToast(final BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("document printed successfully")));
}

void showSharedToast(final BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('something')));
}
