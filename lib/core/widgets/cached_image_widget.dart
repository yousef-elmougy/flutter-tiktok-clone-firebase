import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/constants.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    this.image =
        "https://media.sproutsocial.com/uploads/2021/05/twitter-profile-photo-example.png",
    this.height,
    this.width,
  });

  final String image;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: image,
        height: height,
        width: width,
        placeholder: (_, __) => const ColoredBox(color: kGrayColor),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      );
}
