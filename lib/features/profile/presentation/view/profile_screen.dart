


// import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';
// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
// import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
// import 'package:fashora_app/features/profile/presentation/view_model/profile_event.dart';
// import 'package:fashora_app/features/profile/presentation/view_model/profile_state.dart';
// import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfileScreen extends StatefulWidget {
//   final String userId;

//   const ProfileScreen({super.key, required this.userId});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneNumberController;
//   late TextEditingController _passwordController;
//   int _selectedIndex = 3; // Profile tab index

//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileBloc>().add(LoadProfile());
//     _nameController = TextEditingController();
//     _emailController = TextEditingController();
//     _phoneNumberController = TextEditingController();
//     _passwordController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     if (index == _selectedIndex) return;
//     setState(() {
//       _selectedIndex = index;
//     });
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => FashoraHomeScreen(userId: widget.userId)),
//         );
//         break;
//       case 1:
//         // TODO: Navigate to Wishlist Screen
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const CartScreen()),
//         );
//         break;
//       case 3:
//         // Already here
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color brownDark = Colors.brown.shade700;
//     final Color brownLight = Colors.brown.shade400;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: Stack(
//         children: [
//           // Curved background with gradient
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 height: 160,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [brownDark, brownLight],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: brownDark.withOpacity(0.5),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Title "My Profile" with styling and shadow
//           const Padding(
//             padding: EdgeInsets.only(top: 135, left: 120),
//             child: Text(
//               'My Profile',
//               style: TextStyle(
//                 fontSize: 34,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//                 shadows: [
//                   Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
//                 ],
//               ),
//             ),
//           ),

//           // Main content with padding
//           Padding(
//             padding: const EdgeInsets.only(top: 180, left: 12, right: 12, bottom: 12),
//             child: BlocConsumer<ProfileBloc, ProfileState>(
//               listener: (context, state) {
//                 if (state is ProfileUpdated) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Profile updated successfully")),
//                   );
//                 } else if (state is ProfileError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is ProfileLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is ProfileLoaded || state is ProfileUpdated) {
//                   final profile = state is ProfileLoaded ? state.profile : (state as ProfileUpdated).updatedProfile;

//                   // Initialize controllers with profile data
//                   _nameController.text = profile.name;
//                   _emailController.text = profile.email;
//                   _phoneNumberController.text = profile.phoneNumber;

//                   return SingleChildScrollView(
//                     child: Card(
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       shadowColor: Colors.brown.shade100,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: _nameController,
//                               decoration: InputDecoration(
//                                 labelText: "Name",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(color: brownDark),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 labelText: "Email",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(color: brownDark),
//                                 ),
//                               ),
//                               readOnly: true,
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _phoneNumberController,
//                               decoration: InputDecoration(
//                                 labelText: "Phone Number",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(color: brownDark),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             TextFormField(
//                               controller: _passwordController,
//                               decoration: InputDecoration(
//                                 labelText: "New Password",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(color: brownDark),
//                                 ),
//                               ),
//                               obscureText: true,
//                             ),
//                             const SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 final updatedProfile = ProfileEntity(
//                                   userId: profile.userId,
//                                   name: _nameController.text,
//                                   email: _emailController.text,
//                                   phoneNumber: _phoneNumberController.text,
//                                   profileImageUrl: profile.profileImageUrl,
//                                   address: profile.address,
//                                 );

//                                 context.read<ProfileBloc>().add(
//                                       UpdateProfile(
//                                         updatedProfile,
//                                         newPassword: _passwordController.text.isEmpty
//                                             ? null
//                                             : _passwordController.text,
//                                       ),
//                                     );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: brownDark,
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                               ),
//                               child: const Text(
//                                 "Update Profile",
//                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else if (state is ProfileError) {
//                   return Center(
//                     child: Text(
//                       state.message,
//                       style: TextStyle(color: Colors.red.shade700, fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                   );
//                 }
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.brown.shade700,
//           boxShadow: const [
//             BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1)),
//           ],
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.white,
//           unselectedItemColor: Colors.brown.shade200,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           onTap: _onItemTapped,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//             BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
//             BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
//             BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // The WaveClipper for the curved background
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 50);
//     path.quadraticBezierTo(size.width * 0.8, 130, size.width, 50);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }


import 'package:fashora_app/features/auth/presentation/view/login.dart';
import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';
import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
import 'package:fashora_app/features/profile/domain/entity/profile_entity.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:fashora_app/features/profile/presentation/view_model/profile_viewmodel.dart';
 // Assuming this is the sign-in page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  int _selectedIndex = 3; // Profile tab index

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile());
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FashoraHomeScreen(userId: widget.userId)),
        );
        break;
      case 1:
        // TODO: Navigate to Wishlist Screen
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
        break;
      case 3:
        // Already here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color brownDark = Colors.brown.shade700;
    final Color brownLight = Colors.brown.shade400;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // Curved background with gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [brownDark, brownLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: brownDark.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Title "My Profile" with logo
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: brownDark,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    shadows: [
                      Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main content with padding
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 12, right: 12, bottom: 12),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile updated successfully")),
                  );
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded || state is ProfileUpdated) {
                  final profile = state is ProfileLoaded ? state.profile : (state as ProfileUpdated).updatedProfile;

                  // Initialize controllers with profile data
                  _nameController.text = profile.name;
                  _emailController.text = profile.email;
                  _phoneNumberController.text = profile.phoneNumber;

                  return SingleChildScrollView(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      shadowColor: Colors.brown.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: brownDark),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: brownDark),
                                ),
                              ),
                              readOnly: true,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: brownDark),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: brownDark),
                                ),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final updatedProfile = ProfileEntity(
                                  userId: profile.userId,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  profileImageUrl: profile.profileImageUrl,
                                  address: profile.address,
                                );

                                context.read<ProfileBloc>().add(
                                      UpdateProfile(
                                        updatedProfile,
                                        newPassword: _passwordController.text.isEmpty
                                            ? null
                                            : _passwordController.text,
                                      ),
                                    );
                              },
                           style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.brown.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16), // More rounded corners
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16), // More spacious
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),

                              child: const Text(
                                "Update Profile",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginPage()),
                                );
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.brown.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16), // More modern curve
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16), // Spacious feel
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            child: const Text("Logout"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is ProfileError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red.shade700, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.brown.shade700,
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1)),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.brown.shade200,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
          ],
        ),
      ),
    );
  }
}

// The WaveClipper for the curved background
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 50);
    path.quadraticBezierTo(size.width * 0.8, 130, size.width, 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}