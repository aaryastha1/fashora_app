


// import 'package:fashora_app/features/product/presentation/view_model/product_event.dart';
// import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';
// import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

// class FashoraHomeScreen extends StatefulWidget {
//   const FashoraHomeScreen({Key? key}) : super(key: key);

//   @override
//   _FashoraHomeScreenState createState() => _FashoraHomeScreenState();
// }

// class _FashoraHomeScreenState extends State<FashoraHomeScreen> {
//   final List<String> categories = [
//     'TOPS',
//     'DRESSES',
//     'SHIRTS',
//     'PANTS',
//     'KNITWEAR',
//     'OFFERS',
//   ];

//   int selectedCategoryIndex = 0;

//   final String backendBaseUrl = 'http://10.0.2.2:5006';

//   final ScrollController _categoryScrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchProductsForCategory(categories[selectedCategoryIndex]);
//   }

//   @override
//   void dispose() {
//     _categoryScrollController.dispose();
//     super.dispose();
//   }

//   void _fetchProductsForCategory(String categoryName) {
//     print('Fetching products for category: $categoryName'); // Debug log
//     context.read<ProductBloc>().add(FetchProductsByCategory(categoryName));
//   }

//   void _onCategoryTap(int index) {
//     setState(() {
//       selectedCategoryIndex = index;
//     });
//     _fetchProductsForCategory(categories[index]);

//     // Optional: Scroll to make tapped category visible nicely
//     // Calculate offset for smooth scroll:
//     double offset = index * 100.0; // approx width per item + spacing
//     _categoryScrollController.animateTo(
//       offset,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6EBDD),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Image.asset('assets/images/fashoraa.png', height: 80),
//         actions: [
//           _buildBadgeIcon(Icons.notifications_none),
//           _buildBadgeIcon(Icons.shopping_cart_outlined),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSearchBar(),
//             const SizedBox(height: 8),
//             _buildCategoryList(),
//             const SizedBox(height: 16),
//             _buildProductGrid(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: const [
//           Icon(Icons.search),
//           SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           Icon(Icons.filter_list),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryList() {
//     return SizedBox(
//       height: 48,
//       child: ListView.separated(
//         controller: _categoryScrollController,
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         itemBuilder: (context, index) {
//           final isSelected = selectedCategoryIndex == index;
//           return GestureDetector(
//             onTap: () => _onCategoryTap(index),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.brown.shade300 : Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: isSelected
//                     ? [
//                         BoxShadow(
//                           color: Colors.brown.withOpacity(0.4),
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ]
//                     : [],
//               ),
//               child: Center(
//                 child: Text(
//                   categories[index],
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                     color: isSelected ? Colors.white : Colors.brown.shade700,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductGrid() {
//     return Expanded(
//       child: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProductLoaded) {
//             final products = state.products;
//             if (products.isEmpty) {
//               return const Center(child: Text('No products found'));
//             }
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.68,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return _buildProductCard(products[index]);
//               },
//             );
//           } else if (state is ProductError) {
//             return Center(
//               child: Text(state.message,
//                   style: const TextStyle(color: Colors.red, fontSize: 16)),
//             );
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(ProductEntity product) {
//     final imageUrl = (product.imageUrl.isNotEmpty && product.imageUrl.startsWith('http'))
//         ? product.imageUrl
//         : (product.imageUrl.isNotEmpty ? '$backendBaseUrl/uploads/${product.imageUrl}' : '');

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       errorBuilder: (_, __, ___) =>
//                           const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
//                     )
//                   : const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: const Icon(Icons.shopping_cart_outlined, size: 20),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBadgeIcon(IconData iconData) {
//     return IconButton(
//       icon: Stack(
//         children: [
//           Icon(iconData, color: Colors.black),
//           Positioned(
//             right: 0,
//             top: 0,
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
//               constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
//             ),
//           ),
//         ],
//       ),
//       onPressed: () {},
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xFF8A6D43),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -1))],
//       ),
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         currentIndex: 0,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black45,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         onTap: (index) {
//           // Handle navigation if needed
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/presentation/view/product_detail_screen.dart';

class FashoraHomeScreen extends StatefulWidget {
  const FashoraHomeScreen({Key? key}) : super(key: key);

  @override
  _FashoraHomeScreenState createState() => _FashoraHomeScreenState();
}

class _FashoraHomeScreenState extends State<FashoraHomeScreen> {
  final List<String> categories = [
    'TOPS',
    'DRESSES',
    'SHIRTS',
    'PANTS',
    'KNITWEAR',
    'OFFERS',
  ];

  int selectedCategoryIndex = 0;

  final String backendBaseUrl = 'http://10.0.2.2:5006';

  final ScrollController _categoryScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch products for initial category
    context.read<ProductViewModel>().fetchProductsByCategory(categories[selectedCategoryIndex]);
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
    context.read<ProductViewModel>().fetchProductsByCategory(categories[index]);

    // Optional: Scroll to keep the selected category visible
    double offset = index * 100.0;
    _categoryScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EBDD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/fashoraa.png', height: 80),
        actions: [
          _buildBadgeIcon(Icons.notifications_none),
          _buildBadgeIcon(Icons.shopping_cart_outlined),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 8),
            _buildCategoryList(),
            const SizedBox(height: 16),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
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
          Icon(Icons.filter_list),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        controller: _categoryScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final isSelected = selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => _onCategoryTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.brown.shade300 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.4),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: isSelected ? Colors.white : Colors.brown.shade700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return Expanded(
      child: BlocBuilder<ProductViewModel, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.68,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index]);
              },
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildProductCard(ProductEntity product) {
    final imageUrl = (product.image.isNotEmpty && product.image.startsWith('http'))
        ? product.image
        : (product.image.isNotEmpty ? '$backendBaseUrl/uploads/${product.image}' : '');

    bool isFavorited = false; // Local favorite toggle, replace with real logic

    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) =>
                                const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                          )
                        : const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs. ${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                        size: 32, // Increased size here (default is 24)
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                        // TODO: Add favorite toggle logic
                      },
                    ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadgeIcon(IconData iconData) {
    return IconButton(
      icon: Stack(
        children: [
          Icon(iconData, color: Colors.black),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF8A6D43),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -1))],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          // Handle navigation if needed
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
}
