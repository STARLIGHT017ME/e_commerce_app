import 'package:e_commerce_app/presentation/screens/login/provider/authprovider.dart';
import 'package:e_commerce_app/presentation/screens/login/view/authpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (context, ref, child) {
                      final user = ref.watch(authProvider);
                      return Text(
                        "${user.user?.displayName}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final user = ref.watch(authProvider);

                      return Text(
                        "${user.user?.email}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      );
                    },
                  ),
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
                  _buildOption(Icons.settings, "Settings"),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthPage()));
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
