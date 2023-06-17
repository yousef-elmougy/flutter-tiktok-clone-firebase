import 'package:tiktok_clone/core/widgets/empty_widget.dart';

import '../../../../lib_exports.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
     return BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is GetVideosLoading) {
            return const LoaderWidget();
          }
          final videos = context.read<VideoCubit>().videos;
          return videos.isEmpty
              ? const EmptyWidget(
                  text: 'Add Video',
                  icon: Icon(Icons.queue, size: 150),
                )
              : PageView.builder(
                  controller: PageController(
                    initialPage: currentPage,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  onPageChanged: (page) => setState(() => currentPage = page),
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        VideoWidget(videoUrl: video.videoUrl),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              NameAndCaptionVideoWidget(video: video),
                              ProfileImageAndIconsVideoWidget(video: video),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      );
  }
}
