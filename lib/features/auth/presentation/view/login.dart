// import 'package:fashora_app/View/dashboard_screen.dart';

// import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
// import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool rememberMe = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Image.asset(
//                     'assets/images/fashoraa.png',
//                     height: 120,
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Welcome Back!',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 30),
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Phone / Email',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 9),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: rememberMe,
//                         onChanged: (value) {
//                           setState(() {
//                             rememberMe = value!;
//                           });
//                         },
//                       ),
//                       const Text('Remember Me'),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if(_formKey.currentState!.validate()){
//                           context.read<LoginViewModel>().add(
//                             LoginWithEmailAndPasswordEvent(context: context, 
//                             email: emailController.text, 
//                             password: passwordController.text)
//                           ),
//                         }
//                         // Navigator.pushReplacement(context,
//                         //  MaterialPageRoute(builder: (context)=>DashboardScreen()),
//                         //  );
                        
//                       },
//                       style: ElevatedButton.styleFrom(
//                         // backgroundColor: const Color(0xFF9B7745),
//                         // minimumSize: const Size(double.infinity,50),
                        
//                       ),
//                       child: const Text('Sign In', style: TextStyle(fontSize:18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () {
//                       // Handle forgot password
//                     },
//                     child: const Text('Forgot Password?'),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: const [
//                       Expanded(child: Divider()),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text('OR'),
//                       ),
//                       Expanded(child: Divider()),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   const Text('Sign in with'),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       SocialIcon(icon: FontAwesomeIcons.facebook, color: Colors.blue),
//                       SizedBox(width: 15),
//                       SocialIcon(icon: FontAwesomeIcons.google, color: Colors.red),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account? "),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const RegisterView()),
//                           );
//                         },
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fashora_app/View/dashboard_screen.dart';
import 'package:fashora_app/features/auth/presentation/view/sign_up.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:fashora_app/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/fashoraa.png',
                    height: 120,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your email or phone' : null,
                    decoration: InputDecoration(
                      hintText: 'Phone / Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your password' : null,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                        onPressed: togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text('Remember Me'),
                    ],
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginViewModel>().add(
                                LoginWithEmailAndPasswordEvent(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 160, 91, 91),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Handle forgot password logic
                    },
                    child: const Text('Forgot Password?'),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Sign in with'),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SocialIcon(icon: FontAwesomeIcons.facebook, color: Colors.blue),
                      SizedBox(width: 15),
                      SocialIcon(icon: FontAwesomeIcons.google, color: Colors.red),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterView()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
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
