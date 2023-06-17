import '../../lib_exports.dart';

Future<XFile?> cropImage(XFile file) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
  );
  if (croppedFile == null) return null;
  return XFile(croppedFile.path);
}
