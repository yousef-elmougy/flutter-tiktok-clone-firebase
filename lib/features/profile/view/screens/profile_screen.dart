import 'package:tiktok_clone/features/profile/manager/profile_cubit.dart';
import 'package:tiktok_clone/features/profile/view/widgets/following_and_likes_button_widget.dart';
import 'package:tiktok_clone/features/profile/view/widgets/profile_name_and_image_widget.dart';
import 'package:tiktok_clone/features/profile/view/widgets/thumbnail_grid_view_widget.dart';

import '../../../../lib_exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.uid});

  final String? uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String uid;
  @override
  void initState() {
    super.initState();
    uid = widget.uid ?? FirebaseAuth.instance.currentUser!.uid;
    _getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetUserProfileLoading ||
                state is IsFollowingLoading ||
                state is GetUserVideosDataLoading) {
              return const LoaderWidget();
            } else {
              final user = context.read<ProfileCubit>().user;
              return user == null
                  ? const LoaderWidget()
                  : SafeArea(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          ProfileNameAndImageWidget(user: user, uid: uid),
                          const SizedBox(height: 20),
                          FollowingAndLikesButtonWidget(
                            user: user,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _signOutOrFollowing,
                                  child: Text(
                                    buttonText,
                                    //! follow , unfollow , signout
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const ThumbnailGridViewWidget(),
                        ],
                      ),
                    );
            }
          },
        ),
      );

  Future<void> _getUser() async {
    final cubit = context.read<ProfileCubit>();
    await Future.wait([
      cubit.getUserVideosData(uid),
      cubit.getUserProfile(uid),
      cubit.checkFollowingStatus(uid),
    ]);
  }

  Future<void> _signOutOrFollowing() async {
    if ((uid) == FirebaseAuth.instance.currentUser!.uid) {
      await FirebaseAuth.instance.signOut();
    } else {
      await context.read<ProfileCubit>().followUser(uid);
    }
    await _getUser();
  }

  String get buttonText => (uid) == FirebaseAuth.instance.currentUser!.uid
      ? "SignOut"
      : context.read<ProfileCubit>().isFollowing
          ? "Un Follow"
          : "Follow";
}
