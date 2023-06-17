import '../../../../lib_exports.dart';

class ProfileNameAndImageWidget extends StatelessWidget {
  const ProfileNameAndImageWidget({
    super.key,
    required this.user,
    required this.uid,
  });

  final UserData user;
  final String uid;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (uid != FirebaseAuth.instance.currentUser!.uid)
                const BackButton(),
              if (uid == FirebaseAuth.instance.currentUser!.uid)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_alt_outlined),
                ),
              Text(user.name, style: const TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipOval(
            child: CachedImageWidget(
              image: user.image,
              width: 100,
              height: 100,
            ),
          ),
        ],
      );
}
