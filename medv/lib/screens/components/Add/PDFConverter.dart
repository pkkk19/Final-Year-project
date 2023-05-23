// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart' show rootBundle;

// import 'package:flutter/material.dart';
// import 'package:medv/components/reportViewer.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class ImageToPdfConverter extends StatefulWidget {
//   @override
//   _ImageToPdfConverterState createState() => _ImageToPdfConverterState();
// }

// class _ImageToPdfConverterState extends State<ImageToPdfConverter> {
//   bool _isConverting = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image to PDF Converter'),
//       ),
//       body: Center(
//         child: _isConverting
//             ? CircularProgressIndicator()
//             : ElevatedButton(
//                 onPressed: _createPDF,
//                 child: Text('Convert Image to PDF'),
//               ),
//       ),
//     );
//   }
// }

// Future<void> _createPDF() async {
//   //Create a new PDF document.
//   final PdfDocument document = PdfDocument();
// //Read image data.
//   final Uint8List imageData = File('assets/images/ID.png').readAsBytesSync();
// //Load the image using PdfBitmap.
//   final PdfBitmap image = PdfBitmap(imageData);
// //Draw the image to the PDF page.
//   document.pages
//       .add()
//       .graphics
//       .drawImage(image, const Rect.fromLTWH(0, 0, 500, 200));
// // Save the document.
//   File('ImageToPDF.pdf').writeAsBytes(await document.save());
// // Dispose the document.
//   document.dispose();
// }

// Future<Uint8List> _readImageData(String name) async {
//   final data = await rootBundle.load('images/$name');
//   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// }
