import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/core/functions/show_toast.dart';
import 'package:video_player/video_player.dart';

import 'colored_consol_message.dart';

Future<XFile?> pickVideoLessThanMinute(ImageSource source) async {
  try {
    XFile? pickedVideo = await ImagePicker().pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 1),
    );
    if (pickedVideo == null) return null;
    final controller = VideoPlayerController.file(File(pickedVideo.path));
    await controller.initialize();
    if (controller.value.duration.inSeconds >= 60) {
      pickedVideo = null;
      showToast("we only allow videos that are shorter than 1 minute!");
    } else {
      return pickedVideo;
    }
  } catch (e) {
    printColoredText(text: e.toString(), color: ConsoleColor.red);
  }
  return null;
}
