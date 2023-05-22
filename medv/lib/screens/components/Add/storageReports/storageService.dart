import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> UploadFile(
    String filePath,
    String fileName,
    String folderName,
    String username,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('$username/$folderName/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles(
    String userName,
    String folderName,
  ) async {
    firebase_storage.ListResult result =
        await storage.ref('$userName/$folderName').listAll();
    result.items.forEach((firebase_storage.Reference ref) {
      print("found file: $ref");
    });
    return result;
  }

  Future<String> downloadURL(
    String userName,
    String foldername,
    String fileName,
  ) async {
    String downloadURL =
        await storage.ref('$userName/$foldername/$fileName').getDownloadURL();
    return downloadURL;
  }
}
