import 'package:e_commerce_app/presentation/screens/login/provider/authprovider.dart';
import 'package:e_commerce_app/screendisplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
      isLogin ? _controller.reverse() : _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/image01.jpg", // Replace with your clothing-related image
            fit: BoxFit.cover,
          ),

          // Overlay Gradient for better readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Glassmorphic UI Form
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: isLogin ? _buildLoginForm() : _buildSignUpForm(),
            ),
          ),

          // Toggle Between Login & Sign-up
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: TextButton(
              onPressed: toggleAuthMode,
              child: Text(
                isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Form UI
  Widget _buildLoginForm() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authProvider);

        return _buildGlassForm(
          title: "Welcome Back!",
          subtitle: "Login to continue",
          fields: [
            _buildInputField(Icons.email, "Email", _emailController),
            _buildInputField(Icons.lock, "Password", _passwordController,
                obscureText: true),
          ],
          buttonText: "Login",
          onPressed: () async {
            if (_emailController.text.isEmpty ||
                _passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please fill in all fields"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            print("Email: ${_emailController.text}");
            print("Password: ${_passwordController.text}");

            await ref.read(authProvider.notifier).signIn(
                _emailController.text.trim(), _passwordController.text.trim());

            Future.delayed(const Duration(seconds: 2), () {
              if (ref.read(authProvider).user != null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Screendisplay()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState.message ?? 'Sign-In Failed'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            });
          },
        );
      },
    );
  }

  // Sign-Up Form UI
  Widget _buildSignUpForm() {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authProvider);

        return _buildGlassForm(
          title: "Create an Account",
          subtitle: "Sign up to get started",
          fields: [
            _buildInputField(Icons.person, "Full Name", _nameController),
            _buildInputField(Icons.email, "Email", _emailController),
            _buildInputField(Icons.lock, "Password", _passwordController,
                obscureText: true),
          ],
          buttonText: "Sign Up",
          onPressed: () async {
            if (_emailController.text.isEmpty ||
                _passwordController.text.isEmpty ||
                _nameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please fill in all fields"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            print("Email: ${_emailController.text}");
            print("Password: ${_passwordController.text}");
            print("Name: ${_nameController.text}");

            ref.read(authProvider.notifier).signUp(
                _emailController.text.trim(), _passwordController.text.trim());

            //wait for ui update

            Future.delayed(const Duration(seconds: 2), () {
              if (authState.user != null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Screendisplay()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authState.message ?? 'Sign-Up Failed'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            });
          },
        );
      },
    );
  }

  // Reusable Glassmorphic Form
  Widget _buildGlassForm({
    required String title,
    required String subtitle,
    required List<Widget> fields,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 20),
            ...fields,
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              ),
              child: Text(buttonText, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Input Field
  Widget _buildInputField(
      IconData icon, String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          prefixIcon: Icon(icon, color: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
