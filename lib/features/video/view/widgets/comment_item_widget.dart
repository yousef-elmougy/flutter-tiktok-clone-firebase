import 'package:tiktok_clone/model/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../lib_exports.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget({
    super.key,
    required this.comment,
    required this.videoId,
  });

  final Comment comment;
  final String videoId;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: CachedImageWidget(
              image: comment.commenterImage,
              height: 70,
              width: 70,
            ),
          ),
          const Spacer(flex: 1),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.commenterName,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 20,
                ),
              ),
              Text(
                comment.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(timeago.format(comment.createdAt)),
                  const SizedBox(width: 10),
                  Text('${comment.likes.length} likes'),
                ],
              ),
            ],
          ),
          const Spacer(flex: 4),
          IconButton(
            onPressed: () =>
                context.read<VideoCubit>().likeComment(videoId, comment.id),
            icon: Icon(
              comment.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: kSecondaryColor,
              size: 30,
            ),
          ),
        ],
      );
}
