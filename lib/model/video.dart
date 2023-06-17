import 'package:flutter/foundation.dart';

class Video {
  final String id;
  final String uid;
  final String userImage;
  final String userName;
  final String videoUrl;
  final String caption;
  final String thumbnail;
  final List likes;
  final List sharesUrl;

  const Video({
    required this.id,
    required this.uid,
    required this.userImage,
    required this.userName,
    required this.videoUrl,
    required this.caption,
    required this.thumbnail,
    required this.likes,
    required this.sharesUrl,
  });

  Video copyWith({
    final String? id,
    final String? uid,
    final String? userImage,
    final String? userName,
    final String? videoUrl,
    final String? caption,
    final String? thumbnail,
    final List? likes,
    final List? sharesUrl,
  }) =>
      Video(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        userImage: userImage ?? this.userImage,
        userName: userName ?? this.userName,
        videoUrl: videoUrl ?? this.videoUrl,
        caption: caption ?? this.caption,
        thumbnail: thumbnail ?? this.thumbnail,
        likes: likes ?? this.likes,
        sharesUrl: sharesUrl ?? this.sharesUrl,
      );

  factory Video.fromMap(Map<String, dynamic> map) => Video(
        id: map['id'] ?? '',
        uid: map['uid'] ?? '',
        userImage: map['userImage'] ?? '',
        userName: map['userName'] ?? '',
        videoUrl: map['videoUrl'] ?? '',
        caption: map['caption'] ?? '',
        thumbnail: map['thumbnail'] ?? '',
        likes: List.from(map['likes']),
        sharesUrl: List.from(map['sharesUrl']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'uid': uid,
        'userImage': userImage,
        'userName': userName,
        'videoUrl': videoUrl,
        'caption': caption,
        'thumbnail': thumbnail,
        'likes': likes,
        'sharesUrl': sharesUrl,
      };

  @override
  String toString() =>
      'Video(id: $id, uid: $uid, userImage: $userImage, userName: $userName, videoUrl: $videoUrl, caption: $caption, thumbnail: $thumbnail, likes: $likes, sharesUrl: $sharesUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video &&
        other.id == id &&
        other.uid == uid &&
        other.userImage == userImage &&
        other.userName == userName &&
        other.videoUrl == videoUrl &&
        other.caption == caption &&
        other.thumbnail == thumbnail &&
        listEquals(other.likes, likes) &&
        listEquals(other.sharesUrl, sharesUrl);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      userImage.hashCode ^
      userName.hashCode ^
      videoUrl.hashCode ^
      caption.hashCode ^
      thumbnail.hashCode ^
      likes.hashCode ^
      sharesUrl.hashCode;
}
