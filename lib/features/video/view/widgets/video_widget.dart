import '../../../../lib_exports.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) => setState(() {}))
      ..play();
    // ..setLooping(true);
    context.read<VideoCubit>().videoController = _controller;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => _controller.value.isInitialized
      ? VideoPlayer(_controller)
      : const ColoredBox(color: Colors.black, child: LoaderWidget());
}



 // ..setLooping(true);

    // 

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) async =>
    // ModalRoute.of(context)?.settings.name == AppRouter.videoCommentsScreen
    //     ? await _controller.pause()
    //     : await _controller.play(),
    // );