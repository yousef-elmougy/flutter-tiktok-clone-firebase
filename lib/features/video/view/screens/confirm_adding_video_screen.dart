import 'package:tiktok_clone/features/video/manager/video_cubit.dart';

import '../../../../lib_exports.dart';

class ConfirmAddingVideoScreen extends StatefulWidget {
  const ConfirmAddingVideoScreen({super.key, required this.video});
  final XFile video;
  @override
  State<ConfirmAddingVideoScreen> createState() =>
      _ConfirmAddingVideoScreenState();
}

class _ConfirmAddingVideoScreenState extends State<ConfirmAddingVideoScreen> {
  late VideoPlayerController _controller;
  String? caption;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.video.path))
      ..initialize()
      ..play()
      ..setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Confirm'),
          centerTitle: true,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: double.infinity,
              child: VideoPlayer(_controller),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: TextFormFieldWidget(
                labelText: "Caption",
                validator: null,
                onSaved: (caption) => setState(() => this.caption = caption),
              ),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              onPressed: () async {
                formKey.currentState!.save();
                await _controller.pause();
                if (!mounted) return;
                await context.read<VideoCubit>().uploadVideo(
                      videoPath: widget.video.path,
                      caption: caption ?? '',
                    );
              },
              title: "Share!",
            )
          ],
        ),
      );
}
