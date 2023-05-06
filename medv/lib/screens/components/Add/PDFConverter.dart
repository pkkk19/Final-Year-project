import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:image_picker/image_picker.dart';

class ImageToPdfConverter extends StatefulWidget {
  @override
  _ImageToPdfConverterState createState() => _ImageToPdfConverterState();
}

class _ImageToPdfConverterState extends State<ImageToPdfConverter> {
  XFile? imageFile;
  bool _isConverting = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  void initState() {
    super.initState();
    _pickImage();
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
        title: Text('Image to PDF Converter'),
      ),
      body: Center(
        child: _isConverting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _convertImageToPdf,
                child: Text('Convert Image to PDF'),
              ),
      ),
    );
  }
}
