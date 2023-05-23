import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medv/components/PDFViewerscreen.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Reportviewer extends StatefulWidget {
  const Reportviewer({super.key});

  @override
  State<Reportviewer> createState() => _ReportviewerState();
}

class _ReportviewerState extends State<Reportviewer> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final url = arguments['URL'];
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          width: double.infinity,
          height: 760,
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final imageUrl = url;
            addImageToPDF(imageUrl);
          },
          child: Text('Add Image to PDF'),
        ),
      ],
    );
  }

  Future<void> addImageToPDF(String imageUrl) async {
    // Download the image from the URL
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    // Get the directory for storing the PDF
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/output.pdf';

    // Create the PDF document
    final pdf = pdfWidgets.Document();

    // Create a page with the image as a watermark
    final image = pdfWidgets.MemoryImage(bytes);
    final page = pdfWidgets.Page(
      build: (context) {
        return pdfWidgets.Stack(
          children: [
            pdfWidgets.Image(image),
            // Add other widgets or contents to the page if needed
          ],
        );
      },
    );

    // Add the page to the PDF document
    pdf.addPage(page);

    // Save the PDF to the specified path
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfPath: path),
      ),
    );

    print('PDF saved to: $path');
  }
}
