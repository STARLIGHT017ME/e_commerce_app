import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
          gravity: ToastGravity.SNACKBAR);
      return Future.error(e.message ?? 'An unknown error occurred');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'An error occurred. Please try again.',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
          gravity: ToastGravity.SNACKBAR);
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
      return null;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
        gravity: ToastGravity.BOTTOM,
      );
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'An error occurred. Please try again.',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
          gravity: ToastGravity.SNACKBAR);
    }
  }
}
