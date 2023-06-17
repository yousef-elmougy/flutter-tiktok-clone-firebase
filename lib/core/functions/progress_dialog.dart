import 'package:tiktok_clone/lib_exports.dart';
import 'package:video_compress/video_compress.dart';

Future<void> showProgressDialog(BuildContext context) async => await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        child: ProgressDialogWidget(),
      ),
    );

class ProgressDialogWidget extends StatefulWidget {
  const ProgressDialogWidget({super.key});

  @override
  State<ProgressDialogWidget> createState() => _ProgressDialogWidgetState();
}

class _ProgressDialogWidgetState extends State<ProgressDialogWidget> {
  late Subscription subscription;

  double? progress;

  @override
  void initState() {
    super.initState();

    subscription = VideoCompress.compressProgress$.subscribe(
      (progress) {
        setState(() => this.progress = progress);
        printColoredText(
          text: 'Progress: $progress',
          color: ConsoleColor.green,
        );
      },
    );
  }

  @override
  void dispose() {
    subscription.unsubscribe();
    VideoCompress
      ..cancelCompression()
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uploading... %${progress?.floor() ?? 0}'),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress == null ? progress : progress! / 100,
              color: kSecondaryColor,
              minHeight: 10,
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed:progress == null || progress!.floor() >= 100
                  ? null
                  : () =>  VideoCompress.cancelCompression(),
              title: 'Cancel',
            
            ),
          ],
        ),
      );
}
