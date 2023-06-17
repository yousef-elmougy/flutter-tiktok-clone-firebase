part of 'video_cubit.dart';

@immutable
abstract class VideoState {
  const VideoState();
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

/// Upload video
class UploadVideoLoading extends VideoState {
  const UploadVideoLoading();
}

class UploadVideoSuccess extends VideoState {
  const UploadVideoSuccess();
}

class UploadVideoError extends VideoState {
  final String error;
  const UploadVideoError(this.error);
}

/// Get video
class GetVideosLoading extends VideoState {
  const GetVideosLoading();
}

class GetVideosSuccess extends VideoState {}

class GetVideosError extends VideoState {
  final String error;
  const GetVideosError(this.error);
}

/// Pick video
class PickVideoLoading extends VideoState {
  const PickVideoLoading();
}

class PickVideoSuccess extends VideoState {
  final XFile pickedVideo;
  const PickVideoSuccess(this.pickedVideo);
}

class PickVideoError extends VideoState {
  final String error;
  const PickVideoError(this.error);
}

/// Add Comment
class AddCommentLoading extends VideoState {
  const AddCommentLoading();
}

class AddCommentSuccess extends VideoState {
  const AddCommentSuccess();
}

class AddCommentError extends VideoState {
  final String error;
  const AddCommentError(this.error);
}

/// get Comments
class GetCommentsLoading extends VideoState {
  const GetCommentsLoading();
}

class GetCommentsSuccess extends VideoState {}

class GetCommentsError extends VideoState {
  final String error;
  const GetCommentsError(this.error);
}

/// get Comments Number
class GetCommentLengthSuccess extends VideoState {}
