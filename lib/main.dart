import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/presentation/general_util/themenotifier.dart';
import 'package:e_commerce_app/presentation/screens/login/view/authchecker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider); // Watch theme state

    return MaterialApp(
      themeMode: themeMode, // Apply dynamic theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Authchecker(),
    );
  }
}
