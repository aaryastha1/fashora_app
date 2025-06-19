import 'package:fashora_app/features/auth/presentation/view/login.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:fashora_app/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/fashoraa.png',
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
              _buildInputField(
                controller: _fullNameController,
                hintText: 'Full Name',
                validator: (value) =>
                    value!.isEmpty ? 'Full name is required' : null,
              ),
              _buildInputField(
                controller: _emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email is required';
                  if (!value.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),
              _buildInputField(
                controller: _phoneController,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Phone number is required';
                  if (value.length < 10) return 'Enter a valid phone number';
                  return null;
                },
              ),
              _buildInputField(
                controller: _passwordController,
                hintText: 'Password',
                obscure: true,
                validator: (value) =>
                    value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegisterViewModel>().add(
                        RegisterUserEvent(
                          context: context,
                          fullName: _fullNameController.text,
                          email: _emailController.text,
                          phonenumber: _phoneController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(height: 20),
              const Text('OR'),
              const SizedBox(height: 10),
              const Text(
                'Sign up with',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SocialIcon(icon: FontAwesomeIcons.facebook, color: Colors.blue),
                  SizedBox(width: 20),
                  SocialIcon(icon: FontAwesomeIcons.google, color: Colors.red),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
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
                          fontSize: 15,
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
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      backgroundColor: Colors.white,
      radius: 22,
      child: Icon(icon, size: 20, color: color),
    );
  }
}
