import '../../../../lib_exports.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.videoId});

  final String videoId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController message = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().getComments(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Comments'),
        centerTitle: true,
        leading: BackButton(onPressed: () async {
          final controller = context.read<VideoCubit>().videoController!;
          if (!controller.value.isPlaying) {
            await controller.play();
            Navigator.pop(context);
          }
        }),
      ),
      body: BlocConsumer<VideoCubit, VideoState>(
        listener: _listenToComment,
        builder: (context, state) {
          if (state is GetCommentsLoading) {
            return const LoaderWidget();
          }
          final comments = context.read<VideoCubit>().comments;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: comments.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) => CommentItemWidget(
                    comment: comments[index],
                    videoId: widget.videoId,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: message,
                        border: InputBorder.none,
                        hintText: 'Add Message...',
                        onChanged: (message) =>
                            setState(() => this.message.text = message),
                        suffixIcon: TextButton(
                          onPressed: _addComment,
                          child: const Text(
                            'send',
                            style: TextStyle(fontSize: 20, color: kWhiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _listenToComment(context, state) {
    if (state is AddCommentSuccess) {
      message.clear();
      FocusScope.of(context).unfocus();
    }

    if (state is AddCommentError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
  }

  Future<void> _addComment() async {
    if (message.text.isEmpty) return;
    await context.read<VideoCubit>().addComment(
          videoId: widget.videoId,
          message: message.text,
        );
  }
}
