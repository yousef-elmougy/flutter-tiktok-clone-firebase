import 'package:tiktok_clone/lib_exports.dart';

class FirebaseGlobal {
  FirebaseGlobal._();
  static Future<void> like(DocumentReference<dynamic> document) async {
    try {
      final doc = await document.get().then((doc) => doc.data()!);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      if (doc.likes.contains(uid)) {
        await document.update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await document.update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      printColoredText(text: e.toString(), color: ConsoleColor.red);
    }
  }

  static DocumentReference<UserData> userDocument(String uid) =>
      FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(uid)
          .withConverter(
            fromFirestore: (snapshot, _) => UserData.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
}
