import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    // Add your sign-up logic here
    print("Name: ${_fullNameController.text}");
    print("Email: ${_emailController.text}");
    print("Phone: ${_phoneController.text}");
    print("Password: ${_passwordController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Logo and Store Name
            Image.asset(
                    'assets/images/fashora.png', // Replace with your logo asset
                    height: 130,
                  ),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(_fullNameController, 'Full Name'),
            _buildInputField(_emailController, 'Email'),
            _buildInputField(_phoneController, 'Phone Number'),
            _buildInputField(_passwordController, 'Password', obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB28D5B),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _signUp,
              child: const Text(
                'Sign',
                style: TextStyle(fontSize: 18, color: Colors.white),
                
              ),
              
            ),
            const SizedBox(height: 10),
            const Divider(height: 20),
            const Text('OR'),
            const SizedBox(height: 10),
            const Text('Sign up with',
            style: TextStyle(fontSize: 17 , color: Colors.black),),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SocialIcon(icon: FontAwesomeIcons.facebook, color: Colors.blue),
                SizedBox(width: 20),
                SocialIcon(icon: FontAwesomeIcons.google, color: Colors.yellow),
              ],
            ),

            
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Navigate to Sign In
              },
              child: const Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hintText, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white,
      child: Icon(icon, size: 20, color: color),
    );
  }
}
