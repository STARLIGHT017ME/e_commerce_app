import 'package:e_commerce_app/presentation/general_util/themenotifier.dart';
import 'package:e_commerce_app/presentation/screens/login/provider/authprovider.dart';
import 'package:e_commerce_app/presentation/screens/login/view/authpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userEmail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fechuser();
  }

  void _fechuser() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
    } else {
      setState(() {
        userEmail = 'User not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Profile Header
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    userEmail ?? "Loading....",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Account Options
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildOption(Icons.person, "Edit Profile"),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildOption(Icons.shopping_cart, "My Orders"),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildOption(Icons.notifications, "Notifications"),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildOption(Icons.payment, "Payment Methods"),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildOption(
                    Icons.settings,
                    "Settings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildOption(Icons.help, "Help & Support"),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer(builder: (context, ref, child) {
                    return _buildOption(
                      Icons.logout,
                      "Logout",
                      isLogout: true,
                      onTap: () async {
                        await ref.read(authProvider.notifier).logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthPage()),
                          (route) => false,
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title,
      {bool isLogout = false, VoidCallback? onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.black),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
