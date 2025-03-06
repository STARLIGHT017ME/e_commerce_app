import 'package:e_commerce_app/data/service/auth_service.dart';
import 'package:e_commerce_app/presentation/screens/login/view_model/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Authprovider extends StateNotifier<Authstate> {
  final AuthService _authservice;
  Authprovider(this._authservice) : super(Authstate());

  // Sign up method
  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      User? user = await _authservice.signUp(email, password);
      if (user != null) {
        state = state.copyWith(
            user: user, isLoading: false, message: "Sign-Up Successful");
      } else {
        state = state.copyWith(isLoading: false, message: "Sign-Up Failed");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, message: e.toString());
    }
  }

  // Sign-in method
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      User? user = await _authservice.signIn(email, password);
      if (user != null) {
        state = state.copyWith(
            user: user, isLoading: false, message: "Sign-In Successful");
      } else {
        state = state.copyWith(isLoading: false, message: "Sign-In Failed");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, message: e.toString());
    }
  }

  //reset password
  Future<void> resetPassword(String email) async {
    try {
      await _authservice.resetPassword(email);
      state = state.copyWith(message: "Password reset email sent!");
    } catch (e) {
      state = state.copyWith(message: e.toString());
    }
  }

  Future<void> logout() async {
    await _authservice.signOut();
    state = state.copyWith(user: null, message: "Logged Out", isLoading: false);
  }
}

final authProvider = StateNotifierProvider<Authprovider, Authstate>((ref) {
  return Authprovider(AuthService());
});
