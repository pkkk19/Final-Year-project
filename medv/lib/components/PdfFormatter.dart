// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:medv/components/pdfMobile.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class Pdfformatter extends StatelessWidget {
//   const Pdfformatter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: ElevatedButton(onPressed: _createPDF, child: Text("create PDF")),
//     ));
//   }

//   Future<void> _createPDF() async {
//     PdfDocument document = PdfDocument();
//     document.pages.add();

//     List<int> bytes = document.save() as List<int>;
//     document.dispose();

//     saveAndLaunchFile(bytes, "output.pdf");
//   }
// }
