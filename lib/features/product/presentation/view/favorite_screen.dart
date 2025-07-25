// import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';
// import 'package:fashora_app/features/cart/presentation/view_model/cart_event.dart';
// import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
// import 'package:fashora_app/features/favorite/presentation/view_model/cart_event.dart';
// import 'package:fashora_app/features/favorite/presentation/view_model/cart_view_model.dart';
// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
// import 'package:fashora_app/features/product/presentation/view/product_detail_screen.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_event.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_state.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class WishlistScreen extends StatefulWidget {
//   final String userId;

//   const WishlistScreen({super.key, required this.userId});

//   @override
//   State<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   int _selectedIndex = 1;

//   @override
//   void initState() {
//     super.initState();
//     context.read<FavoriteBloc>().add(LoadFavoritesEvent());
//   }

//   void _onItemTapped(int index) {
//     if (index == _selectedIndex) return;
//     setState(() => _selectedIndex = index);
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => FashoraHomeScreen(userId: widget.userId)),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const CartScreen()),
//         );
//         break;
//       case 3:
//         // TODO: Profile Screen
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
//           const Padding(
//             padding: EdgeInsets.only(top: 150, left: 148),
//             child: Text(
//               'Wishlist',
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
//           Padding(
//             padding: const EdgeInsets.only(top: 180, left: 12, right: 12, bottom: 12),
//             child: BlocConsumer<FavoriteBloc, FavoriteState>(
//               listener: (context, state) {
//                 if (state is FavoriteError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 if (state is FavoriteLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is FavoriteLoaded) {
//                   final favorites = state.favorites;
//                   if (favorites.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No favorites yet.',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.brown.shade400,
//                         ),
//                       ),
//                     );
//                   }
//                   return ListView.separated(
//                     itemCount: favorites.length,
//                     separatorBuilder: (_, __) => const Divider(height: 12),
//                     itemBuilder: (context, index) {
//                       final product = favorites[index];
//                       final imageUrl = (product.image.isNotEmpty && product.image.startsWith('http'))
//                           ? product.image
//                           : (product.image.isNotEmpty ? 'http://10.0.2.2:5006/uploads/${product.image}' : '');

//                       return Card(
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         shadowColor: Colors.brown.shade100,
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           leading: GestureDetector(
//                             onTap: () {
//                               // Navigator.push(
//                               //   context,
//                               //   // MaterialPageRoute(
//                               //   //   builder: (_) => ProductDetailScreen(product: product),
//                               //   // ),
//                               // );
//                             },
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: imageUrl.isNotEmpty
//                                   ? Image.network(
//                                       imageUrl,
//                                       width: 60,
//                                       height: 60,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
//                                     )
//                                   : const Icon(Icons.image_not_supported, size: 60),
//                             ),
//                           ),
//                           title: Text(
//                             product.name,
//                             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                           ),
//                           subtitle: Text(
//                             "Price: Rs. ${product.price}",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: Colors.brown.shade700,
//                               fontSize: 14,
//                             ),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.shopping_cart_outlined, color: Colors.brown, size: 26),
//                                 tooltip: 'Add to Cart',
//                                 onPressed: () {
//                                   context.read<CartBlocFavorite>().add(AddProductToCart(product.id ?? ''));
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text('${product.name} added to cart'),
//                                       duration: const Duration(seconds: 2),
//                                       behavior: SnackBarBehavior.floating,
//                                       backgroundColor: Colors.green,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.favorite, color: Colors.red, size: 28),
//                                 tooltip: 'Remove from favorites',
//                                 onPressed: () {
//                                   final productId = product.id ?? '';
//                                   context.read<FavoriteBloc>().add(ToggleFavoriteEvent(productId));
//                                   context.read<FavoriteBloc>().add(LoadFavoritesEvent()); // reload updated list
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is FavoriteError) {
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
//           boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1))],
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



import 'package:fashora_app/features/favorite/presentation/view_model/cart_event.dart';
import 'package:fashora_app/features/favorite/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/product/presentation/view/product_detail_screen.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
import 'package:fashora_app/features/cart/presentation/view/cart_screen.dart';

import 'package:fashora_app/features/product/presentation/view_model/favorite_event.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_state.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';

class WishlistScreen extends StatefulWidget {
  final String userId;
  const WishlistScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavoritesEvent());
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FashoraHomeScreen(userId: widget.userId)),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
        break;
      case 3:
        // TODO: Profile Screen
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
          const Padding(
            padding: EdgeInsets.only(top: 150, left: 148),
            child: Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                shadows: [
                  Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 12, right: 12, bottom: 12),
            child: BlocConsumer<FavoriteBloc, FavoriteState>(
              listener: (context, state) {
                if (state is FavoriteError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FavoriteLoaded) {
                  final favorites = state.favorites;
                  if (favorites.isEmpty) {
                    return Center(
                      child: Text(
                        'No favorites yet.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown.shade400,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: favorites.length,
                    separatorBuilder: (_, __) => const Divider(height: 12),
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      final imageUrl = (product.image.isNotEmpty && product.image.startsWith('http'))
                          ? product.image
                          : (product.image.isNotEmpty ? 'http://10.0.2.2:5006/uploads/${product.image}' : '');

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        shadowColor: Colors.brown.shade100,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                             onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(product: product),
                                ),
                              );
                            },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                                  )
                                : const Icon(Icons.image_not_supported, size: 60),
                          ),
                          title: Text(
                            product.name,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          subtitle: Text(
                            "Price: Rs. ${product.price}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.brown.shade700,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.brown, size: 26),
                                tooltip: 'Add to Cart',
                                onPressed: () {
                                  context.read<CartBlocFavorite>().add(AddProductToCart(product.id ?? ''));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} added to cart'),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite, color: Colors.red, size: 28),
                                tooltip: 'Remove from favorites',
                                onPressed: () {
                                  final productId = product.id ?? '';
                                  context.read<CartBlocFavorite>().add(AddProductToCart(product.id ?? ''));

                                  // context.read<FavoriteBloc>().add(ToggleFavoriteEvent(productId));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FavoriteError) {
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
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1))],
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
