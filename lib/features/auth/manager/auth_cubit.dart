import '../../../lib_exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());
  File? file;

  Future<void> _createUser({
    required String name,
    required String uid,
    required String email,
    required String image,
  }) async {
    final user = UserData(
      uid: uid,
      image: image,
      name: name,
      email: email,
      followers: [],
      following: [],
    );
    try {
      await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(uid)
          .withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromMap(
              snapshot.data()!,
            ),
            toFirestore: (user, _) => user.toMap(),
          )
          .set(user);
    } on FirebaseException catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());
    String error = "Something Went Wrong";
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(const LoginSuccess());
    } on FirebaseAuthException catch (e) {
      error = _getFirebaseAuthErrorMessage(e);
    } catch (e) {
      error = e.toString();
    }
    if (state is! LoginSuccess) {
      printColoredText(text: error, color: ConsoleColor.red);
      emit(LoginError(error));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());
    String error = "Something Went Wrong!!";
    String image = "";
    try {
      if (file == null) {
        error = 'image is required';
      } else {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = user.user!.uid;

        image = await uploadFile(file!, 'images/user/$uid');

        await _createUser(
          name: name,
          uid: user.user!.uid,
          email: email,
          image: image,
        );
        emit(const RegisterSuccess());
      }
    } on FirebaseAuthException catch (e) {
      error = _getFirebaseAuthErrorMessage(e);
    } catch (e) {
      error = e.toString();
    }
    if (state is! RegisterSuccess) {
      printColoredText(text: error, color: ConsoleColor.red);
      emit(RegisterError(error));
    }
  }

  Future<void> pickedImage(ImageSource source) async {
    emit(const PickImageLoading());
    try {
      file = await pickImage(source);
      emit(const PickImageSuccess());
    } catch (e) {
      printColoredText(
        text: e.toString(),
        color: ConsoleColor.red,
      );
      emit(PickImageError(e.toString()));
    }
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return e.message.toString();
    }
  }
}
