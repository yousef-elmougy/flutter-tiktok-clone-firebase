import '../../lib_exports.dart';

// Future<File?> pickImage(ImageSource source) async {
//   try {
//     final imagePicker = ImagePicker();
//     final file = await imagePicker.pickImage(source: source);

//     if (file != null) {
//       final croppedFile = await cropImage(file);
//       if (croppedFile != null) {
//         return File(croppedFile.path);
//         // return await croppedFile.readAsBytes();
//       }
//     }
//   } on PlatformException catch (e) {
//     debugPrint('Failed to pick image: $e');
//   }
//   return null;
// }

Future<File?> pickImage(ImageSource source) async {
  try {

    final file = await ImagePicker().pickImage(source: source);
    if (file == null) return null;

    final croppedFile = await cropImage(file);
    if (croppedFile == null) return null;

    return File(croppedFile.path);
    // return await croppedFile.readAsBytes();
  } on PlatformException catch (e) {
    debugPrint('Failed to pick image: $e');
  }
  return null;
}
