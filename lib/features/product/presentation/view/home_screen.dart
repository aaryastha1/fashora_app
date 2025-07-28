



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:fashora_app/features/product/presentation/view/product_detail_screen.dart';
// import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';
// import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
// import 'package:fashora_app/app/service_locator/service_locator.dart';
// import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
// import 'package:fashora_app/features/product/presentation/view/favorite_screen.dart'; // WishlistScreen
// import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';
// import 'package:fashora_app/features/profile/presentation/view/profile_screen.dart';
// import 'package:fashora_app/features/auth/presentation/view/dashboard_screen.dart';

// class FashoraHomeScreen extends StatefulWidget {
//   final String userId;
//   final int initialCategoryIndex;

//   const FashoraHomeScreen({
//     Key? key,
//     required this.userId,
//     this.initialCategoryIndex = 0,
//   }) : super(key: key);

//   @override
//   _FashoraHomeScreenState createState() => _FashoraHomeScreenState();
// }

// class _FashoraHomeScreenState extends State<FashoraHomeScreen> {
//   final List<String> categories = ['TOPS', 'SHIRTS', 'DRESSES', 'PANTS', 'KNITWEAR', 'OFFERS'];
//   late int selectedCategoryIndex;
//   // final String backendBaseUrl = 'http://10.0.2.2:5006';
//   final String backendBaseUrl = 'http://192.168.1.72:5006';

//   final ScrollController _categoryScrollController = ScrollController();
//   int _currentIndex = 0;
//   Set<String> favoriteProductIds = {};
//   String searchQuery = '';
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     selectedCategoryIndex = widget.initialCategoryIndex;
//     context.read<ProductViewModel>().fetchProductsByCategory(categories[selectedCategoryIndex]);
//     _fetchFavorites();
//     _scrollToInitialCategory();
//   }

//   void _scrollToInitialCategory() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _categoryScrollController.jumpTo(selectedCategoryIndex * 100.0);
//     });
//   }

//   Future<void> _fetchFavorites() async {
//     try {
//       final result = await serviceLocator<IFavoriteRepository>().getFavorites();
//       result.fold(
//         (failure) {
//           debugPrint("Error loading favorites: ${failure.message}");
//         },
//         (favorites) {
//           setState(() {
//             favoriteProductIds = favorites.map((e) => e.id ?? '').toSet();
//           });
//         },
//       );
//     } catch (e) {
//       debugPrint("Unexpected error loading favorites: $e");
//     }
//   }

//   void _onCategoryTap(int index) {
//     setState(() {
//       selectedCategoryIndex = index;
//       searchQuery = '';
//       _searchController.clear();
//     });
//     context.read<ProductViewModel>().fetchProductsByCategory(categories[index]);
//     _categoryScrollController.animateTo(
//       index * 100.0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _onSearch(String query) {
//     setState(() {
//       searchQuery = query;
//     });
//     if (query.isNotEmpty) {
//       context.read<ProductViewModel>().searchProducts(query);
//     } else {
//       context.read<ProductViewModel>().fetchProductsByCategory(categories[selectedCategoryIndex]);
//     }
//   }

//   @override
//   void dispose() {
//     _categoryScrollController.dispose();
//     _searchController.dispose();
//     super.dispose();
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
//           onPressed: () {
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
//           },
//         ),
//         title: Image.asset('assets/images/fashoraa.png', height: 80),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
//             },
//           ),
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
//             Expanded(child: _buildProductList()),
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
//         children: [
//           const Icon(Icons.search),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               onChanged: _onSearch,
//               decoration: const InputDecoration(
//                 hintText: "Search",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           const Icon(Icons.filter_list),
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
//                 color: isSelected ? Colors.brown.shade400 : Colors.white,
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
//                     color: isSelected ? Colors.white : Colors.brown.shade900,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductList() {
//     return BlocBuilder<ProductViewModel, ProductState>(
//       builder: (context, state) {
//         if (state is ProductLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ProductLoaded) {
//           final products = state.products;
//           if (products.isEmpty) {
//             return const Center(child: Text('No products found'));
//           }
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 16,
//               childAspectRatio: 0.68,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               final isFavorited = favoriteProductIds.contains(product.id);
//               return _buildProductCard(product, isFavorited);
//             },
//           );
//         } else if (state is ProductError) {
//           return Center(
//             child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 16)),
//           );
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }

//   Widget _buildProductCard(ProductEntity product, bool isFavorited) {
//     final imageUrl = (product.image.isNotEmpty && product.image.startsWith('http'))
//         ? product.image
//         : (product.image.isNotEmpty ? '$backendBaseUrl/uploads/${product.image}' : '');

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: imageUrl.isNotEmpty
//                     ? Image.network(
//                         imageUrl,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         errorBuilder: (_, __, ___) => const Center(
//                           child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
//                         ),
//                       )
//                     : const Center(
//                         child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
//                       ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//               child: Text(
//                 product.name,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Rs. ${product.price}",
//                     style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       isFavorited ? Icons.favorite : Icons.favorite_border,
//                       color: isFavorited ? Colors.red : Colors.grey,
//                       size: 28,
//                     ),
//                     onPressed: () => _toggleFavorite(product),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _toggleFavorite(ProductEntity product) async {
//     final productId = product.id ?? '';
//     final productName = product.name;

//     try {
//       final toggleResult = await serviceLocator<IFavoriteRepository>().toggleFavorite(productId);
//       toggleResult.fold(
//         (failure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to toggle favorite: ${failure.message}')),
//           );
//         },
//         (newStatus) {
//           setState(() {
//             if (newStatus) {
//               favoriteProductIds.add(productId);
//             } else {
//               favoriteProductIds.remove(productId);
//             }
//           });

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 newStatus ? '$productName added to favorites' : '$productName removed from favorites',
//                 style: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               duration: const Duration(seconds: 3),
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.green,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               action: SnackBarAction(
//                 label: 'Undo',
//                 textColor: Colors.white,
//                 onPressed: () async {
//                   final undoResult = await serviceLocator<IFavoriteRepository>().toggleFavorite(productId);
//                   undoResult.fold(
//                     (failure) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Undo failed: ${failure.message}')),
//                       );
//                     },
//                     (undoStatus) {
//                       setState(() {
//                         if (undoStatus) {
//                           favoriteProductIds.add(productId);
//                         } else {
//                           favoriteProductIds.remove(productId);
//                         }
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Unexpected error: $e')),
//       );
//     }
//   }

//   Widget _buildBottomNavigationBar() {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color.fromARGB(255, 101, 66, 56),
//         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -1))],
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       child: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black45,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         onTap: (index) {
//           if (index == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => WishlistScreen(userId: widget.userId)),
//             );
//           } else if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const CartScreen()),
//             );
//           } else if (index == 3) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => ProfileScreen(userId: widget.userId)),
//             );
//           } else {
//             setState(() {
//               _currentIndex = index;
//             });
//           }
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/presentation/view/product_detail_screen.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:fashora_app/app/service_locator/service_locator.dart';
import 'package:fashora_app/features/product/domain/repository/favorite_repository.dart';
import 'package:fashora_app/features/product/presentation/view/favorite_screen.dart'; // WishlistScreen
import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';
import 'package:fashora_app/features/profile/presentation/view/profile_screen.dart';
import 'package:fashora_app/features/auth/presentation/view/dashboard_screen.dart';

class FashoraHomeScreen extends StatefulWidget {
  final String userId;
  final int initialCategoryIndex;

  const FashoraHomeScreen({
    Key? key,
    required this.userId,
    this.initialCategoryIndex = 0,
  }) : super(key: key);

  @override
  _FashoraHomeScreenState createState() => _FashoraHomeScreenState();
}

class _FashoraHomeScreenState extends State<FashoraHomeScreen> {
  final List<String> categories = ['TOPS', 'SHIRTS', 'DRESSES', 'PANTS', 'KNITWEAR', 'OFFERS'];
  late int selectedCategoryIndex;
  final String backendBaseUrl = 'http://192.168.1.72:5006';

  final ScrollController _categoryScrollController = ScrollController();
  int _currentIndex = 0;
  Set<String> favoriteProductIds = {};
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  bool _tiltCooldown = false;

  @override
  void initState() {
    super.initState();
    selectedCategoryIndex = widget.initialCategoryIndex;
    context.read<ProductViewModel>().fetchProductsByCategory(categories[selectedCategoryIndex]);
    _fetchFavorites();
    _scrollToInitialCategory();
    _listenToGyroscope();
  }

  void _listenToGyroscope() {
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (_tiltCooldown) return;

      const double tiltThreshold = 1.5; // Sensitivity

      // Only handle tilt right: event.y < -threshold
      if (event.y < -tiltThreshold) {
        if (selectedCategoryIndex < categories.length - 1) {
          _onCategoryTap(selectedCategoryIndex + 1);
          _triggerTiltCooldown();
        }
      }
    });
  }

  void _triggerTiltCooldown() {
    _tiltCooldown = true;
    Future.delayed(const Duration(seconds: 1), () {
      _tiltCooldown = false;
    });
  }

  void _scrollToInitialCategory() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoryScrollController.jumpTo(selectedCategoryIndex * 100.0);
    });
  }

  Future<void> _fetchFavorites() async {
    try {
      final result = await serviceLocator<IFavoriteRepository>().getFavorites();
      result.fold(
        (failure) {
          debugPrint("Error loading favorites: ${failure.message}");
        },
        (favorites) {
          setState(() {
            favoriteProductIds = favorites.map((e) => e.id ?? '').toSet();
          });
        },
      );
    } catch (e) {
      debugPrint("Unexpected error loading favorites: $e");
    }
  }

  void _onCategoryTap(int index) {
    setState(() {
      selectedCategoryIndex = index;
      searchQuery = '';
      _searchController.clear();
    });
    context.read<ProductViewModel>().fetchProductsByCategory(categories[index]);
    _categoryScrollController.animateTo(
      index * 100.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query;
    });
    if (query.isNotEmpty) {
      context.read<ProductViewModel>().searchProducts(query);
    } else {
      context.read<ProductViewModel>().fetchProductsByCategory(categories[selectedCategoryIndex]);
    }
  }

  @override
  void dispose() {
    _gyroscopeSubscription.cancel();
    _categoryScrollController.dispose();
    _searchController.dispose();
    super.dispose();
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
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
          },
        ),
        title: Image.asset('assets/images/fashoraa.png', height: 80),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
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
            Expanded(child: _buildProductList()),
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
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.filter_list),
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
                color: isSelected ? Colors.brown.shade400 : Colors.white,
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
                    color: isSelected ? Colors.white : Colors.brown.shade900,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    return BlocBuilder<ProductViewModel, ProductState>(
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
              final product = products[index];
              final isFavorited = favoriteProductIds.contains(product.id);
              return _buildProductCard(product, isFavorited);
            },
          );
        } else if (state is ProductError) {
          return Center(
            child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 16)),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildProductCard(ProductEntity product, bool isFavorited) {
    final imageUrl = (product.image.isNotEmpty && product.image.startsWith('http'))
        ? product.image
        : (product.image.isNotEmpty ? '$backendBaseUrl/uploads/${product.image}' : '');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
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
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      ),
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
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                    onPressed: () => _toggleFavorite(product),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(ProductEntity product) async {
    final productId = product.id ?? '';
    final productName = product.name;

    try {
      final toggleResult = await serviceLocator<IFavoriteRepository>().toggleFavorite(productId);
      toggleResult.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to toggle favorite: ${failure.message}')),
          );
        },
        (newStatus) {
          setState(() {
            if (newStatus) {
              favoriteProductIds.add(productId);
            } else {
              favoriteProductIds.remove(productId);
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                newStatus ? '$productName added to favorites' : '$productName removed from favorites',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              action: SnackBarAction(
                label: 'Undo',
                textColor: Colors.white,
                onPressed: () async {
                  final undoResult = await serviceLocator<IFavoriteRepository>().toggleFavorite(productId);
                  undoResult.fold(
                    (failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Undo failed: ${failure.message}')),
                      );
                    },
                    (undoStatus) {
                      setState(() {
                        if (undoStatus) {
                          favoriteProductIds.add(productId);
                        } else {
                          favoriteProductIds.remove(productId);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 101, 66, 56),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, -1))],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WishlistScreen(userId: widget.userId)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen(userId: widget.userId)),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
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
