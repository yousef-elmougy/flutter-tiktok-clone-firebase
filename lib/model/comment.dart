import 'package:flutter/foundation.dart';

class Comment {
  final String id;
  final String commenterId;
  final String message;
  final String commenterImage;
  final String commenterName;
  final DateTime createdAt;
  final List likes;

  const Comment({
    required this.id,
    required this.commenterId,
    required this.message,
    required this.commenterImage,
    required this.commenterName,
    required this.createdAt,
    required this.likes,
  });

  Comment copyWith({
    final String? id,
    final String? commenterId,
    final String? message,
    final String? commenterImage,
    final String? commenterName,
    final DateTime? createdAt,
    final List? likes,
  }) =>
      Comment(
        id: id ?? this.id,
        commenterId: commenterId ?? this.commenterId,
        message: message ?? this.message,
        commenterImage: commenterImage ?? this.commenterImage,
        commenterName: commenterName ?? this.commenterName,
        createdAt: createdAt ?? this.createdAt,
        likes: likes ?? this.likes,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'commenterId': commenterId,
        'message': message,
        'commenterImage': commenterImage,
        'commenterName': commenterName,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'likes': likes,
      };

  factory Comment.fromMap(Map<String, dynamic> map) => Comment(
        id: map['id'] ?? '',
        commenterId: map['commenterId'] ?? '',
        message: map['message'] ?? '',
        commenterImage: map['commenterImage'] ?? '',
        commenterName: map['commenterName'] ?? '',
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        likes: List.from(map['likes']),
      );

  @override
  String toString() =>
      'Comment(id: $id, commenterId: $commenterId, message: $message, commenterImage: $commenterImage, commenterName: $commenterName, createdAt: $createdAt, likes: $likes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.commenterId == commenterId &&
        other.message == message &&
        other.commenterImage == commenterImage &&
        other.commenterName == commenterName &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      commenterId.hashCode ^
      message.hashCode ^
      commenterImage.hashCode ^
      commenterName.hashCode ^
      createdAt.hashCode ^
      likes.hashCode;
}
