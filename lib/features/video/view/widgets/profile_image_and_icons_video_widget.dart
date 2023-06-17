import '../../../../lib_exports.dart';

class ProfileImageAndIconsVideoWidget extends StatefulWidget {
  const ProfileImageAndIconsVideoWidget({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  State<ProfileImageAndIconsVideoWidget> createState() =>
      _ProfileImageAndIconsVideoWidgetState();
}

class _ProfileImageAndIconsVideoWidgetState
    extends State<ProfileImageAndIconsVideoWidget> {
  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().getCommentsLength(widget.video.id);
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: kWhiteColor,
                radius: 31,
                child: ClipOval(
                  child: CachedImageWidget(
                    image: widget.video.userImage,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Positioned(
                bottom: -7,
                left: 21,
                child: ClipOval(
                  child: CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    radius: 10,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          IconButton(
            iconSize: 40,
            onPressed: () =>
                context.read<VideoCubit>().likeVideo(widget.video.id),
            icon: Icon(
              widget.video.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined, 
            ),
          ),
          Text('${widget.video.likes.length}'),
          const SizedBox(height: 10),
          IconButton(
            iconSize: 40,
            onPressed: () async {
              await context.read<VideoCubit>().videoController!.pause();
              Navigator.pushNamed(
                context,
                AppRouter.videoCommentsScreen,
                arguments: widget.video.id,
              );
            },
            icon: const Icon(Icons.message),
          ),
          Text('${context.read<VideoCubit>().commentsLength}'),
          const SizedBox(height: 10),
          IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: const Icon(Icons.reply),
          ),
          Text('${widget.video.sharesUrl.length}'),
          const SizedBox(height: 10),
        ],
      );
}
