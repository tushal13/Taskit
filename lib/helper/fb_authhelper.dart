import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:taskit/helper/fb_storehelper.dart';

class FBAuthHelper {
  late FirebaseFirestore firestore;
  late FirebaseAuth auth;

  FBAuthHelper._init() {
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;
  }

  static FBAuthHelper fbAuthHelper = FBAuthHelper._init();

  String collectionName = 'users';

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          signInWithEmailAndPassword(email, password);
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Signed in with email and password.\nUser: ${userCredential.user}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          print(
              "The password is invalid or the user does not have a password.");
          break;
        case "user-not-found":
          print("No user found for the provided email.");
          break;
        default:
          print("Unknown error. ${e.code}");
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      await FbStoreHelper.fbStoreHelper
          .addUser(email: userCredential.user!.email!);
      Logger().i("Signed in with Google.\nUser: ${userCredential.user}");
      return userCredential;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }
}
