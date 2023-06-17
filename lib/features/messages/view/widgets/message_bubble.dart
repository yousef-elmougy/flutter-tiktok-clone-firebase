import '../../../../lib_exports.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.isImage,
    // required this.message,
  });

  final bool isMe;
  final bool isImage;
  // final Message message;

  @override
  Widget build(BuildContext context) => Align(
        alignment: isMe ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? kSecondaryColor : Colors.grey,
            borderRadius: isMe
                ? const BorderRadius.all(Radius.circular(30))
                    .copyWith(bottomLeft: const Radius.circular(0))
                : const BorderRadius.all(Radius.circular(30))
                    .copyWith(bottomRight: const Radius.circular(0)),
          ),
          margin: const EdgeInsets.all(10).copyWith(bottom: 0),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              if (isImage == true)
                // Container(
                //   height: 200,
                //   width: 200,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     image: DecorationImage(
                //       image: NetworkImage(message.content),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                if (isImage == false)
                  const Text(
                    '',
                    // message.content,
                    style: TextStyle(color: kWhiteColor),
                  ),
              const SizedBox(height: 5),
              const Text(
                'Hello Hello Hello Hello Hello Hello Hello ',
                // timeago.format(message.sentTime),
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
}
