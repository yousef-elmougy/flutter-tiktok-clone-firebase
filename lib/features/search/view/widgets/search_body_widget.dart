import '../../../../lib_exports.dart';

class SearchBodyWidget extends StatelessWidget {
  const SearchBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchUsersLoading) {
            return const LoaderWidget();
          }
          final users = context.read<SearchCubit>().users;
          return users.isEmpty
              ? const EmptyWidget(
                  text: 'Search',
                  icon: Icon(
                    Icons.search,
                    size: 150,
                  ),
                )
              : ListView.separated(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.white38),
                  itemBuilder: (context, index) =>
                      users[index].uid == FirebaseAuth.instance.currentUser!.uid
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRouter.profileScreen,
                                  arguments: users[index].uid),
                              child: ListTile(
                                leading: ClipOval(
                                  child: CachedImageWidget(
                                    image: users[index].image,
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                                title: Text(
                                  users[index].name,
                                  style: const TextStyle(
                                    color: kSecondaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                );
        },
      );
}
