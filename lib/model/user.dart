import 'package:flutter/foundation.dart';

class UserData {
  final String uid;
  final String image;
  final String email;
  final String name;
  final List followers;
  final List following;

  const UserData({
    required this.uid,
    required this.image,
    required this.email,
    required this.name,
    required this.followers,
    required this.following,
  });

  UserData copyWith({
    final String? uid,
    final String? image,
    final String? email,
    final String? name,
    final List? followers,
    final List? following,
  }) =>
      UserData(
        uid: uid ?? this.uid,
        image: image ?? this.image,
        email: email ?? this.email,
        name: name ?? this.name,
        followers: followers ?? this.followers,
        following: following ?? this.following,
      );

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'image': image,
        'email': email,
        'name': name,
        'followers': followers,
        'following': following,
      };

  factory UserData.fromMap(Map<String, dynamic> map) => UserData(
        uid: map['uid'] ?? '',
        image: map['image'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        followers: List.from(map['followers']),
        following: List.from(map['following']),
      );

  @override
  String toString() =>
      'UserData(uid: $uid, image: $image, email: $email, name: $name, followers: $followers, following: $following)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.image == image &&
        other.email == email &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following) &&
        other.name == name;
  }

  @override
  int get hashCode =>
      uid.hashCode ^
      image.hashCode ^
      email.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      name.hashCode;
}
