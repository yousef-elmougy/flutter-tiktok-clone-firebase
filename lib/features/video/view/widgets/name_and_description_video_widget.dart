import '../../../../lib_exports.dart';

class NameAndCaptionVideoWidget extends StatelessWidget {
  const NameAndCaptionVideoWidget({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            video.caption,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
}
