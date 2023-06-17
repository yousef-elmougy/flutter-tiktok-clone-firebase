import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/widgets/empty_widget.dart';
import 'package:tiktok_clone/features/messages/view/widgets/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    // required this.receiverId,
  });
  // final String receiverId;

  @override
  Widget build(BuildContext context) => false
      ? const EmptyWidget(
          text: "Say Hello!",
          icon: Icon(Icons.waving_hand),
        )
      : Expanded(
        child: ListView.builder(
          // controller: Provider.of<FirebaseProvider>(context, listen: false)
          //     .scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
                       return const MessageBubble(
              isMe: true,
              // message: value.messages[index],
              isImage: false,
            );
          },
        ),
      );
}
