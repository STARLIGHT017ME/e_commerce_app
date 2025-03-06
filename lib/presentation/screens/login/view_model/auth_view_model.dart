import 'package:firebase_auth/firebase_auth.dart';

class Authstate {
  final User? user;
  final bool isLoading;
  final String? message;

  Authstate({this.user, this.isLoading = false, this.message});

  Authstate copyWith({User? user, bool? isLoading, String? message}) {
    return Authstate(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message);
  }
}
