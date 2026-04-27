import 'package:firebase_auth/firebase_auth.dart';
import 'package:prana_ai/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create firebaseUser user obj
  MyUser? userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //  auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  //  Sign in anonymously
  Future<MyUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print("Firebase Error: ${e.message}");
      return null;
    } catch (e) {
      print("Unknown Error: $e");
      return null;
    }
  }

  //  Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }
}
