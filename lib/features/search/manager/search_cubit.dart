import '../../../lib_exports.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  List<UserData> users = [];

  void searchUsers(String name) {
    if (name.isEmpty) {
      clearUsers();
      return;
    }
    emit(const SearchUsersLoading());
    try {
      FirebaseFirestore.instance
          .collection(kUserCollection)
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: "${name}z")
          .snapshots()
          .listen((users) {
        this.users = users.docs.map((e) => UserData.fromMap(e.data())).toList();
        emit(SearchUsersSuccess());
      });
    } catch (e) {
      emit(SearchUsersError(e.toString()));
    }
  }

  void clearUsers() {
    users = [];
    emit(ClearUsers());
  }
}
