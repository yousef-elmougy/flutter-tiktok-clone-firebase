import '../../../../lib_exports.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.user});
  
  final UserData user;

  @override
  State<MessagesScreen> createState() => _MessagesStateScreen();
}

class _MessagesStateScreen extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ClipOval(
                child: CachedImageWidget(
                  image: widget.user.image,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                widget.user.name,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ChatMessages(
                  // receiverId: receiverId,
                  ),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      hintText: 'Add Message...',
                      suffixIcon: TextButton(
                        child: const Text(
                          'send',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
