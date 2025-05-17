import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  title: Image.asset(
    'assets/images/fashora.png', // Your uploaded logo
    height: 70,
  ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text(
      //     'Fashora',
      //     style: TextStyle(
      //       fontFamily: 'Pacifico', // Optional for stylish look
      //       fontSize: 24,
      //       color: Color(0xFF8A6D43),
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: CircleAvatar(
        //       backgroundImage: AssetImage('assets/profile_icon.png'), // replace with actual asset
        //       radius: 18,
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image with "Shop Now"
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/shop.png',
                    fit: BoxFit.cover,
                  ),


                ),
              ),
             
              SizedBox(height: 40),
              Center(
                child: Text(
                  'SHOP NOW',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF8A6D43),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Offers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Center(
                     child: Image.asset(
                      'assets/images/offer.png', // replace with your image asset
                      fit: BoxFit.cover,
                    ),

                    ),
                    
                    Positioned(
                      bottom: 0,
                      right: 28,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFF8A6D43),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Know More',
                          style: TextStyle(
                            color: Colors.white, fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: const Color(0xFF8A6D43), // Your brown color
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black45,          // Highlighted icon
      unselectedItemColor: Colors.black45,      // Dimmed unselected icons
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      onTap: null,
        // setState(() {
        //   _currentIndex = index;
        // });
      // },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
    ),

      
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color(0xFF8A6D43),
      //   currentIndex: _currentIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.black45,
      //      showSelectedLabels: false,
      //      showUnselectedLabels: false,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite_border),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_outline),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
