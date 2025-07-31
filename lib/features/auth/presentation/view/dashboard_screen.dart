

// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
// import 'package:flutter/material.dart';

// class DashboardScreen extends StatefulWidget {
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;

//   // Define your brown dark color
//   final Color brownDark = const Color(0xFF654238);

//   final List<Widget> _screens = [
//     const DashboardContent(),
//     FashoraHomeScreen(userId: ''),
//     Placeholder(), // Favorites Screen placeholder
//     Placeholder(), // Cart Screen placeholder
//     Placeholder(), // Profile Screen placeholder
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: brownDark,
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

// class DashboardContent extends StatelessWidget {
//   const DashboardContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Image.asset(
//           'assets/images/fashoraa.png',
//           height: 80,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(14),
//                   child: Image.asset(
//                     'assets/images/shop.png',
//                     fit: BoxFit.cover,
//                     height: 340, // smaller height for the first image
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30), // reduced spacing
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FashoraHomeScreen(userId: ''),
//                       ),
//                     );
//                   },
//                   style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // smaller padding
//                     backgroundColor: Colors.brown,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       side: const BorderSide(color: Colors.brown),
//                     ),
//                   ),
//                   child: const Text(
//                     'EXPLORE NOW',
//                     style: TextStyle(
//                       fontSize: 16, // smaller font size
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Offers',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 15),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: Image.asset(
//                         'assets/images/offer.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 28,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         decoration: const BoxDecoration(
//                           color: Colors.brown,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                           ),
//                         ),
//                         child: const Text(
//                           'SHOP NOW',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
          
           
          
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryCard(String title, String imagePath) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         height: 190, // bigger category cards
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 height: 130, // bigger image inside the card
//                 width: double.infinity,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: DashboardContent(),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/fashoraa.png',
          height: 80,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/shop.png',
                    fit: BoxFit.cover,
                    height: 340,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FashoraHomeScreen(userId: ''),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.brown),
                    ),
                  ),
                  child: const Text(
                    'EXPLORE NOW',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Offers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/offer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 28,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'SHOP NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

