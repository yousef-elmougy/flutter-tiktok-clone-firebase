part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Get User
class GetUserProfileLoading extends ProfileState {
  const GetUserProfileLoading();
}

class GetUserProfileSuccess extends ProfileState {}

class GetUserProfileError extends ProfileState {
  final String error;
  const GetUserProfileError(this.error);
}

/// Get User Likes and thumbnails
class GetUserVideosDataLoading extends ProfileState {
  const GetUserVideosDataLoading();
}

class GetUserVideosDataSuccess extends ProfileState {}

class GetUserVideosDataError extends ProfileState {
  final String error;
  const GetUserVideosDataError(this.error);
}

/// Check Following Status
class IsFollowingLoading extends ProfileState {
  const IsFollowingLoading();
}

class IsFollowingSuccess extends ProfileState {}

class IsFollowingError extends ProfileState {
  final String error;
  const IsFollowingError(this.error);
}


