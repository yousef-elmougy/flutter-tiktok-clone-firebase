import 'package:tiktok_clone/core/functions/progress_dialog.dart';
import 'package:tiktok_clone/features/video/manager/video_cubit.dart';

import '../../../../lib_exports.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<VideoCubit, VideoState>(
        listener: _listenToPickAndUploadVideo,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: ButtonWidget(
              onPressed: () => _addVideo(context),
              title: 'Add Video',
            ),
          ),
        ),
      );

  Future<void> _listenToPickAndUploadVideo(context, state) async {
    if (state is UploadVideoLoading) {
      await showProgressDialog(context);
    }
    if (state is UploadVideoError) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast(state.error);
    }
    if (state is PickVideoSuccess) {
      Navigator.pushNamed(
        context,
        AppRouter.confirmAddingVideoScreen,
        arguments: state.pickedVideo,
      );
    }
    if (state is UploadVideoSuccess) {
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      hideToast();
      showToast('Video Uploaded Successfully', color: Colors.green);
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    }
  }

  Future<void> _addVideo(BuildContext context) => showCameraGalleryDialog(
        context,
        pickedByCamera: () async =>
            await context.read<VideoCubit>().pickVideo(ImageSource.camera),
        pickedByGallery: () async =>
            await context.read<VideoCubit>().pickVideo(ImageSource.gallery),
      );
}
