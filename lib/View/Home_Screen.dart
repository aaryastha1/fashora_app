import 'package:flutter/material.dart';

class FashoraHomeScreen extends StatefulWidget {
  @override
  _FashoraHomeScreenState createState() => _FashoraHomeScreenState();
}

class _FashoraHomeScreenState extends State<FashoraHomeScreen> {
  int _selectedIndex = 0;

  final List<String> categories = [
    'Shirts & Tops',
    'Dresses',
    'Jackets',
    'Knitwear',
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EBDD),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6EBDD),
        elevation: 0,
        title: Image.asset(
          'assets/images/fashora.png', // Replace with your actual logo image path
          height: 30,
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_none, color: Colors.black),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                  ),
                )
              ],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart_outlined, color: Colors.black),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                  ),
                )
              ],
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.filter_list)
                ],
              ),
            ),
            // Categories
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() => selectedCategoryIndex = index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: selectedCategoryIndex == index ? Colors.black : Colors.grey,
                          decoration: selectedCategoryIndex == index
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Product Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.68,
                children: [
                  _buildProductCard("assets/images/tee.png", "Basic fitted top", "Rs. 1300"),
                  _buildProductCard("assets/images/shirt.png", "Oversize shirt", "Rs. 1999"),
                  _buildProductCard("assets/images/top.png", "Round neck tee", "Rs. 899"),
                  _buildProductCard("assets/images/top1.png", "Brown fitted top", "Rs. 1499"),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF8A6D433),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildProductCard(String image, String title, String price) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(price, style: TextStyle(color: Colors.black87)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.shopping_cart_outlined, size: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
