import '../../lib_exports.dart';

Future<void> showCameraGalleryDialog(
  BuildContext context, {
  required VoidCallback pickedByCamera,
  required VoidCallback pickedByGallery,
}) async =>
    await showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (_) => SimpleDialog(
        children: [
          SimpleDialogOption(
            child: const Text('Camera'),
            onPressed: () {
              pickedByCamera();
              Navigator.pop(context);
            },
          ),
          const Divider(),
          SimpleDialogOption(
            child: const Text('Gallery'),
            onPressed: () {
              pickedByGallery();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
