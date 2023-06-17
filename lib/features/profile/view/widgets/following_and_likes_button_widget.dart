import 'package:tiktok_clone/features/profile/manager/profile_cubit.dart';

import '../../../../lib_exports.dart';

class FollowingAndLikesButtonWidget extends StatelessWidget {
  const FollowingAndLikesButtonWidget({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                '${user.following.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Following"),
            ],
          ),
          Column(
            children: [
              Text(
                '${user.followers.length}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text("Followers"),
            ],
          ),
          Column(
            children: [
              Text(
                "${context.read<ProfileCubit>().userLikes}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Likes"),
            ],
          ),
        ],
      );
}
