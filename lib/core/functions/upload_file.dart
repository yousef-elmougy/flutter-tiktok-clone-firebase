import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadFile(File file, String storagePath) async {
  final taskSnapshot =
      await FirebaseStorage.instance.ref().child(storagePath).putFile(file);
  return taskSnapshot.ref.getDownloadURL();
}
