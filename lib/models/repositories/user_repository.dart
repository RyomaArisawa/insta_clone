import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_clone/models/db/database_manager.dart';

import '../data_models/user.dart';

class UserRepository {
  static User? currentUser;

  final DatabaseManager databaseManager;
  UserRepository({required this.databaseManager});

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await databaseManager.getUserInfoById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn() async {
    try {
      //Googleアカウントへサインイン
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      //Googleアカウントが認証できない場合はreturn
      if (signInAccount == null) return false;

      //Googleアカウント認証情報を取得
      GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      //Googleアカウント認証情報からcredentialを作成
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
          idToken: signInAuthentication.idToken,
          accessToken: signInAuthentication.accessToken);

      //credentialでfirebaseへサインインを実行し、ユーザ情報を取得
      final auth.User? user =
          (await _auth.signInWithCredential(credential)).user;
      //サインインができず、ユーザ情報が取得できなかった場合はreturn
      if (user == null) return false;

      //同一のユーザがDB登録されているか確認
      bool isUserExisted = await databaseManager.searchUserInDB(user);

      //まだ登録されていない場合
      if (!isUserExisted) {
        await databaseManager.insertUser(_convertUser(user));
      }

      //ユーザ情報をDBから取得
      currentUser = await databaseManager.getUserInfoById(user.uid);
      return true;
    } catch (error) {
      print("sign in failed: ${error.toString()}");
      return false;
    }
  }

  _convertUser(auth.User user) {
    return User(
      userId: user.uid,
      displayName: user.displayName ?? "",
      inAppUserName: user.displayName ?? "",
      photoUrl: user.photoURL ?? "",
      email: user.email ?? "",
      bio: "",
    );
  }
}
