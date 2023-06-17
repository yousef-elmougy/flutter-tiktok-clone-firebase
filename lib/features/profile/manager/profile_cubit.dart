import 'package:tiktok_clone/core/functions/firebase_global_methods.dart';

import '../../../lib_exports.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());
  UserData? user;
  bool isFollowing = false;
  int userLikes = 0;
  List<String> thumbnails = [];

  Future<void> getUserProfile(String uid) async {
    emit(const GetUserProfileLoading());

    try {
      await FirebaseGlobal.userDocument(uid).get().then((user) {
        this.user = user.data()!;
        emit(GetUserProfileSuccess());
      });
    } catch (e) {
      emit(GetUserProfileError(e.toString()));
    }
  }

  Future<void> getUserVideosData(String uid) async {
    emit(const GetUserVideosDataLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(kVideoCollection)
          .where('uid', isEqualTo: uid)
          .get();
      userLikes = snapshot.docs.fold<int>(0, (total, doc) {
        final likes = Video.fromMap(doc.data()).likes;
        return total + likes.length;
      });
      thumbnails = snapshot.docs
          .map<String>((doc) => Video.fromMap(doc.data()).thumbnail)
          .toList();
      emit(GetUserVideosDataSuccess());
    } catch (e) {
      emit(GetUserVideosDataError(e.toString()));
    }
  }
/* 
  
TODO: uid = followingId

TODO: currentUser (uid)---->> following ---->> followerUser (followerId)  

TODO: followerUser (followerId) ---->> follower ---->> currentUser (uid)   

 */

  Future<void> followUser(String followerId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final currentUser = FirebaseGlobal.userDocument(uid);
    final followerUser = FirebaseGlobal.userDocument(followerId);
    if (isFollowing) {
      followerUser.update({
        'followers': FieldValue.arrayRemove([uid])
      });
      currentUser.update({
        'following': FieldValue.arrayRemove([followerId])
      });
    } else {
      followerUser.update({
        'followers': FieldValue.arrayUnion([uid])
      });
      currentUser.update({
        'following': FieldValue.arrayUnion([followerId])
      });
    }
  }

  Future<void> checkFollowingStatus(String followerId) async {
    emit(const IsFollowingLoading());
    try {
      isFollowing = await FirebaseGlobal.userDocument(
        FirebaseAuth.instance.currentUser!.uid,
      ).get().then((value) => value.data()!.following.contains(followerId));
      emit(IsFollowingSuccess());
    } catch (e) {
      emit(IsFollowingError(e.toString()));
    }
  }
}
