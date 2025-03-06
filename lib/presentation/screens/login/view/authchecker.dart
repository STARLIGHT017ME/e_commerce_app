import 'package:e_commerce_app/presentation/screens/login/view/authpage.dart';
import 'package:e_commerce_app/screendisplay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authchecker extends StatelessWidget {
  const Authchecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return const Screendisplay();
        }
        return const AuthPage();
      },
    );
  }
}
