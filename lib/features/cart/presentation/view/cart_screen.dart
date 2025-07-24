// import 'package:fashora_app/features/product/presentation/view/favorite_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
// import 'package:fashora_app/features/cart/presentation/view_model/cart_event.dart';
// import 'package:fashora_app/features/cart/presentation/view_model/cart_state.dart';
// import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
// import 'package:fashora_app/features/product/presentation/view/home_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   int _selectedIndex = 2; // Cart tab index

//   @override
//   void initState() {
//     super.initState();
//     context.read<CartBloc>().add(LoadCartEvent());
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
//           MaterialPageRoute(builder: (_) => const FashoraHomeScreen(userId: '')),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const WishlistScreen(userId: '')),
//         );
//         break;
//       case 2:
//         break;
//       case 3:
//         // TODO: Profile
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color brownDark = Colors.brown.shade700;
//     final Color brownLight = Colors.brown.shade400;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6EBDD),
//       body: Stack(
//         children: [
//           // Top curved background with gradient
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 height: 140,
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

//           // Title
//           const Padding(
//             padding: EdgeInsets.only(top: 135, left: 120),
//             child: Text(
//               'My Cart',
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

//           // Cart items + summary + checkout
//           Padding(
//             padding: const EdgeInsets.only(top: 180, left: 12, right: 12, bottom: 12),
//             child: BlocBuilder<CartBloc, CartState>(
//               builder: (context, state) {
//                 if (state is CartLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is CartLoaded) {
//                   final cart = state.cart;

//                   if (cart.items.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         'Your cart is empty',
//                         style: TextStyle(fontSize: 18, color: Colors.brown),
//                       ),
//                     );
//                   }

//                   double subtotal = cart.items.fold(
//                     0,
//                     (sum, item) => sum + item.price * item.quantity,
//                   );
//                   double shipping = 150;
//                   double total = subtotal + shipping;

//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           itemCount: cart.items.length,
//                           separatorBuilder: (_, __) => const SizedBox(height: 14),
//                           itemBuilder: (context, index) {
//                             final item = cart.items[index];
//                             final imageUrl = (item.image != null && item.image!.isNotEmpty)
//                                 ? 'http://10.0.2.2:5006/uploads/${item.image}'
//                                 : '';

//                             return Card(
//                               elevation: 4,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16)),
//                               shadowColor: Colors.brown.shade100,
//                               child: ListTile(
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                                 leading: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: imageUrl.isNotEmpty
//                                       ? Image.network(
//                                           imageUrl,
//                                           width: 70,
//                                           height: 70,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (_, __, ___) =>
//                                               const Icon(Icons.broken_image, size: 70),
//                                         )
//                                       : const Icon(Icons.image_not_supported, size: 70),
//                                 ),
//                                 title: Text(
//                                   item.name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w700, fontSize: 18),
//                                 ),
//                                 subtitle: Text(
//                                   "Rs. ${item.price.toStringAsFixed(2)}",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: brownDark,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 trailing: SizedBox(
//                                   width: 140,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(Icons.remove_circle_outline),
//                                         color: brownDark,
//                                         onPressed: () {
//                                           if (item.quantity > 1) {
//                                             context.read<CartBloc>().add(
//                                                 UpdateQuantityEvent(item.id, item.quantity - 1));
//                                           } else {
//                                             context
//                                                 .read<CartBloc>()
//                                                 .add(RemoveFromCartEvent(item.id));
//                                           }
//                                         },
//                                       ),
//                                       Text(
//                                         item.quantity.toString(),
//                                         style: const TextStyle(fontSize: 17),
//                                       ),
//                                       IconButton(
//                                         icon: const Icon(Icons.add_circle_outline),
//                                         color: brownDark,
//                                         onPressed: () {
//                                           context.read<CartBloc>().add(
//                                               UpdateQuantityEvent(item.id, item.quantity + 1));
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 14),
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 16,
//                               color: Colors.black.withOpacity(0.07),
//                               offset: const Offset(0, -4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             _rowLabel('Subtotal', subtotal, brownDark),
//                             _rowLabel('Shipping', shipping, brownDark),
//                             const Divider(height: 30, thickness: 1.2),
//                             _rowLabel('Total', total, brownDark, bold: true, fontSize: 20),
//                             const SizedBox(height: 16),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // TODO: Add checkout functionality
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.brown,
//                                 padding: const EdgeInsets.symmetric(vertical: 16),
//                                 minimumSize: const Size(double.infinity, 50),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Proceed to Checkout',
//                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   );
//                 } else if (state is CartError) {
//                   return Center(
//                     child: Text(
//                       'Error: ${state.message}',
//                       style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//                     ),
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: brownDark,
//           boxShadow: const [
//             BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1))
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

//   Widget _rowLabel(String label, double value, Color textColor,
//       {bool bold = false, double fontSize = 16}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                 fontWeight: bold ? FontWeight.bold : FontWeight.w500,
//                 fontSize: fontSize,
//                 color: textColor,
//               )),
//           Text('Rs. ${value.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontWeight: bold ? FontWeight.bold : FontWeight.w500,
//                 fontSize: fontSize,
//                 color: textColor,
//               )),
//         ],
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


import 'package:fashora_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:fashora_app/features/product/presentation/view/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_event.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_state.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import 'package:fashora_app/features/order/presentation/view/order_screen.dart';
import 'package:fashora_app/features/profile/presentation/view/profile_screen.dart'; // ✅ Added

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedIndex = 2; // Cart tab index

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
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
          MaterialPageRoute(builder: (_) => const FashoraHomeScreen(userId: '')),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WishlistScreen(userId: '')),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen(userId: '',)), // ✅ ProfileScreen Navigation
        );
        break;
    }
  }

  void _proceedToCheckout(List<CartItemEntity> items) {
    final orderItems = items
        .map((cartItem) => OrderItemEntity(
              productId: cartItem.id,
              quantity: cartItem.quantity,
            ))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderScreen(items: orderItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color brownDark = Colors.brown.shade700;
    final Color brownLight = Colors.brown.shade400;

    return Scaffold(
      backgroundColor: const Color(0xFFF6EBDD),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 140,
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
            padding: EdgeInsets.only(top: 135, left: 120),
            child: Text(
              'My Cart',
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
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CartLoaded) {
                  final cart = state.cart;

                  if (cart.items.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 18, color: Colors.brown),
                      ),
                    );
                  }

                  double subtotal = cart.items.fold(
                    0,
                    (sum, item) => sum + item.price * item.quantity,
                  );
                  double shipping = 150;
                  double total = subtotal + shipping;

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: cart.items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final item = cart.items[index];
                            final imageUrl = (item.image != null && item.image!.isNotEmpty)
                                ? 'http://10.0.2.2:5006/uploads/${item.image}'
                                : '';

                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              shadowColor: Colors.brown.shade100,
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.broken_image, size: 70),
                                        )
                                      : const Icon(Icons.image_not_supported, size: 70),
                                ),
                                title: Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Rs. ${item.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: brownDark,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 140,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle_outline),
                                        color: brownDark,
                                        onPressed: () {
                                          if (item.quantity > 1) {
                                            context.read<CartBloc>().add(
                                                UpdateQuantityEvent(item.id, item.quantity - 1));
                                          } else {
                                            context
                                                .read<CartBloc>()
                                                .add(RemoveFromCartEvent(item.id));
                                          }
                                        },
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle_outline),
                                        color: brownDark,
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                              UpdateQuantityEvent(item.id, item.quantity + 1));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 16,
                              color: Colors.black.withOpacity(0.07),
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _rowLabel('Subtotal', subtotal, brownDark),
                            _rowLabel('Shipping', shipping, brownDark),
                            const Divider(height: 30, thickness: 1.2),
                            _rowLabel('Total', total, brownDark, bold: true, fontSize: 20),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _proceedToCheckout(cart.items),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Proceed to Checkout',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                } else if (state is CartError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: brownDark,
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -1))
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

  Widget _rowLabel(String label, double value, Color textColor,
      {bool bold = false, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                fontSize: fontSize,
                color: textColor,
              )),
          Text('Rs. ${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                fontSize: fontSize,
                color: textColor,
              )),
        ],
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
