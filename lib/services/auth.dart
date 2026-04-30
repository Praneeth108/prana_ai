import 'package:firebase_auth/firebase_auth.dart';
import 'package:prana_ai/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Convert Firebase user → MyUser
  MyUser? userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth state stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  // ✅ Sign in with Email
  Future<MyUser?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.message}");
      return null;
    }
  }

  // ✅ Register new user
  Future<MyUser?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print("Register Error: ${e.message}");
      return null;
    }
  }

  // Optional: Anonymous login
  Future<MyUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return userFromFirebaseUser(result.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }
}
