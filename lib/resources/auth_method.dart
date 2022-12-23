import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/util.dart';

//google sign in authentication has been done
class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authChange => auth.authStateChanges();


  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleauth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleauth?.accessToken,
        idToken: googleauth?.idToken,
      );

      UserCredential userCredential =
      await auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await firestore.collection('user').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilephoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }
}
