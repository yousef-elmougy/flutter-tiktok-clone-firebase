import 'package:tiktok_clone/features/messages/manager/messages_cubit.dart';

import '../../../../lib_exports.dart';

class UsersMessagesScreen extends StatelessWidget {
  const UsersMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            if (state is GetAllUsersLoading) {
              return const LoaderWidget();
            }
            final users = context.read<MessagesCubit>().users;
            return ListView.separated(
              itemCount: users.length,
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) =>
                  users[index].uid == FirebaseAuth.instance.currentUser!.uid
                      ? const SizedBox.shrink()
                      : const Column(
                          children: [
                            SizedBox(height: 5),
                            Divider(color: Colors.white38),
                            SizedBox(height: 5),
                          ],
                        ),
              itemBuilder: (context, index) =>
                  users[index].uid == FirebaseAuth.instance.currentUser!.uid
                      ? const SizedBox.shrink()
                      : InkWell(
                          //! onTap: () => Navigator.pushNamed(
                          //!   context,
                          //!   AppRouter.messagesScreen,
                          //!   arguments: users[index],
                          //! ),

                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRouter.profileScreen,
                            arguments: users[index].uid,
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: CachedImageWidget(
                                image: users[index].image,
                                height: 55,
                                width: 55,
                              ),
                            ),
                            title: Text(
                              users[index].name,
                              style: const TextStyle(
                                color: kSecondaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
            );
          },
        ),
      );
}
