import 'package:tiktok_clone/core/functions/firebase_global_methods.dart';
import 'package:tiktok_clone/core/functions/pick_video_less_minute.dart';
import 'package:tiktok_clone/model/comment.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../../../lib_exports.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(const VideoInitial());

  List<Video> videos = [];
  List<Comment> comments = [];
  int commentsLength = 0;
  VideoPlayerController? videoController;

  /// VIDEO  ---------------------------------------------------------------------------
  Future<void> uploadVideo({
    required String videoPath,
    required String caption,
  }) async {
    emit(const UploadVideoLoading());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final videoId = const Uuid().v4();
      final user = await FirebaseGlobal.userDocument(uid)
          .get()
          .then((value) => value.data()!);
      final videoFile = await _compressVideo(videoPath);
      final thumbnailFile = await _getFileThumbnail(videoPath);
      final videoUrl = await uploadFile(videoFile!, 'videos/$videoId');
      final thumbnail = await uploadFile(thumbnailFile, 'thumbnails/$videoId');

      final video = Video(
        id: videoId,
        uid: uid,
        userImage: user.image,
        userName: user.name,
        videoUrl: videoUrl,
        caption: caption,
        thumbnail: thumbnail,
        likes: [],
        sharesUrl: [],
      );

      await _videoDocument(videoId).set(video);

      emit(const UploadVideoSuccess());
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
      emit(UploadVideoError(e.toString()));
    }
  }

  Future<void> pickVideo(ImageSource source) async {
    emit(const PickVideoLoading());
    try {
      final pickedVideo = await pickVideoLessThanMinute(source);

      emit(PickVideoSuccess(pickedVideo!));
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
      emit(PickVideoError(e.toString()));
    }
  }

  void getVideos() {
    emit(const GetVideosLoading());
    try {
      FirebaseFirestore.instance
          .collection(kVideoCollection)
          .snapshots()
          .listen(
        (video) {
          videos = video.docs.map((e) => Video.fromMap(e.data())).toList();
          emit(GetVideosSuccess());
        },
      );
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
      emit(GetVideosError(e.toString()));
    }
  }

  Future<void> likeVideo(String videoId) async => await FirebaseGlobal.like(_videoDocument(videoId));

  /// COMMENTS ---------------------------------------------------------------------------
  Future<void> likeComment(String videoId, String commentId) async =>
      await FirebaseGlobal.like(_commentDocument(videoId, commentId));

  Future<void> addComment({
    required String videoId,
    required String? message,
  }) async {
    emit(const AddCommentLoading());
    if (message == null) return;

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final id = const Uuid().v4();
      final user = await FirebaseGlobal.userDocument(uid)
          .get()
          .then((value) => value.data()!);

      final comment = Comment(
        id: id,
        commenterId: user.uid,
        message: message,
        commenterName: user.name,
        commenterImage: user.image,
        createdAt: DateTime.now(),
        likes: [],
      );
      await _commentDocument(videoId, id).set(comment);
      emit(const AddCommentSuccess());
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
      emit(AddCommentError(e.toString()));
    }
  }

  void getComments(String videoId) {
    emit(const GetCommentsLoading());

    try {
      _videoDocument(videoId)
          .collection(kCommentsCollection)
          .snapshots()
          .listen((comments) {
        this.comments =
            comments.docs.map((e) => Comment.fromMap(e.data())).toList();
        emit(GetCommentsSuccess());
      });
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
      emit(GetCommentsError(e.toString()));
    }
  }

  void getCommentsLength(String videoId) {
    try {
      _videoDocument(videoId)
          .collection(kCommentsCollection)
          .snapshots()
          .listen((event) {
        commentsLength = event.docs.length;
        emit(GetCommentLengthSuccess());
      });
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
    }
  }

  /// PRIVET METHODS ---------------------------------------------------------------------------

  DocumentReference<Video> _videoDocument(String videoId) =>
      FirebaseFirestore.instance
          .collection(kVideoCollection)
          .doc(videoId)
          .withConverter(
            fromFirestore: (snapshot, _) => Video.fromMap(snapshot.data()!),
            toFirestore: (video, _) => video.toMap(),
          );
  DocumentReference<Comment> _commentDocument(
          String videoId, String commentId) =>
      _videoDocument(videoId)
          .collection(kCommentsCollection)
          .doc(commentId)
          .withConverter(
            fromFirestore: (comment, _) => Comment.fromMap(comment.data()!),
            toFirestore: (comment, _) => comment.toMap(),
          );

  Future<File?> _compressVideo(String videoPath) async {
    final mediaInfo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    if (mediaInfo == null) return null;
    final file = mediaInfo.file;
    if (file == null) return null;
    return file;
  }

  Future<File> _getFileThumbnail(String videoPath) async =>
      await VideoCompress.getFileThumbnail(videoPath);
}
