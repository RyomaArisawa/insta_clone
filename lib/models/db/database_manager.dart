import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:insta_clone/models/data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searchUserInDB(auth.User user) async {
    final query = await _db
        .collection("users")
        .where("userId", isEqualTo: user.uid)
        .get();
    if (query.docs.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoById(String uid) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: uid).get();
    return User.fromMap(query.docs[0].data());
  }
}
