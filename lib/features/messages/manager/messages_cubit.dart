import 'package:tiktok_clone/model/chat.dart';

import '../../../lib_exports.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(const MessagesInitial());

  List<UserData> users = [];

  void getAllUsers() {
    emit(const GetAllUsersLoading());
    try {
      FirebaseFirestore.instance
          .collection(kUserCollection)
          .snapshots()
          .listen((users) {
        this.users = users.docs.map((e) => UserData.fromMap(e.data())).toList();
        emit(GetAllUsersSuccess());
      });
    } catch (e) {
      emit(GetAllUsersError(e.toString()));
    }
  }

 
}
