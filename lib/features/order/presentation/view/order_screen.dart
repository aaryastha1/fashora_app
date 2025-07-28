// import 'package:fashora_app/features/order/presentation/view/order_succes_screen.dart';
// import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
// import '../view_model/order_event.dart';
// import '../view_model/order_state.dart';

// class OrderScreen extends StatefulWidget {
//   final List<OrderItemEntity> items;

//   const OrderScreen({super.key, required this.items});

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   String _paymentMethod = 'cod'; // default value

//   void _submitOrder() {
//     if (_formKey.currentState!.validate()) {
//       final order = OrderEntity(
//         fullName: _fullNameController.text.trim(),
//         address: _addressController.text.trim(),
//         phone: _phoneController.text.trim(),
//         paymentMethod: _paymentMethod,
//         items: widget.items,
//       );

//       context.read<OrderBloc>().add(PlaceOrderEvent(order));
//     }
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _addressController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color brownDark = Colors.brown.shade700;
//     final Color brownLight = Colors.brown.shade400;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF6EBDD),
//       appBar: AppBar(
//         backgroundColor: brownDark,
//         title: const Text('Place Order'),
//         centerTitle: true,
//         elevation: 6,
//       ),
//       body: Stack(
//         children: [
//           // Top curved background
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
//             padding: EdgeInsets.only(top: 135, left: 24),
//             child: Text(
//               'Shipping Details',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//                 shadows: [
//                   Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
//                 ],
//               ),
//             ),
//           ),

//           // Form Container
//           Padding(
//             padding: const EdgeInsets.only(top: 190, left: 16, right: 16, bottom: 12),
//             child: BlocConsumer<OrderBloc, OrderState>(
//               listener: (context, state) {
//                 if (state is OrderSuccess) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (_) => const OrderSuccessScreen(userId: '',)),
//                   );
//                 } else if (state is OrderFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.message)),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         _buildTextField(
//                           controller: _fullNameController,
//                           label: 'Full Name',
//                           validatorMsg: 'Please enter your name',
//                         ),
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           controller: _addressController,
//                           label: 'Address',
//                           validatorMsg: 'Please enter your address',
//                         ),
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           controller: _phoneController,
//                           label: 'Phone Number',
//                           keyboardType: TextInputType.phone,
//                           validatorMsg: 'Please enter your phone number',
//                         ),
//                         const SizedBox(height: 20),
//                         DropdownButtonFormField<String>(
//                           value: _paymentMethod,
//                           decoration: InputDecoration(
//                             labelText: 'Payment Method',
//                             labelStyle: TextStyle(color: brownDark),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: brownLight),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: brownDark, width: 2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                           ),
//                           dropdownColor: Colors.brown[50],
//                           items: const [
//                             DropdownMenuItem(value: 'cod', child: Text('Cash On Delivery')),
//                             // DropdownMenuItem(value: 'esewa', child: Text('eSewa')),
//                             // DropdownMenuItem(value: 'khalti', child: Text('Khalti')),
//                           ],
//                           onChanged: (value) {
//                             setState(() {
//                               _paymentMethod = value!;
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 32),
//                         ElevatedButton(
//                           onPressed: state is OrderLoading ? null : _submitOrder,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.brown,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: state is OrderLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                                   'Place Order',
//                                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String validatorMsg,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     final brownDark = Colors.brown.shade700;
//     final brownLight = Colors.brown.shade400;
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: brownDark),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: brownLight),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: brownDark, width: 2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//       validator: (value) => (value == null || value.isEmpty) ? validatorMsg : null,
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




import 'package:fashora_app/features/order/presentation/view/order_succes_screen.dart';
import 'package:fashora_app/features/order/presentation/view_model/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashora_app/features/order/domain/entity/order_item_entity.dart';
import '../view_model/order_event.dart';
import '../view_model/order_state.dart';

// Import your CartBloc and event to clear cart
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_event.dart';

class OrderScreen extends StatefulWidget {
  final List<OrderItemEntity> items;

  const OrderScreen({super.key, required this.items});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _paymentMethod = 'cod'; // default value

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      final order = OrderEntity(
        fullName: _fullNameController.text.trim(),
        address: _addressController.text.trim(),
        phone: _phoneController.text.trim(),
        paymentMethod: _paymentMethod,
        items: widget.items,
      );

      context.read<OrderBloc>().add(PlaceOrderEvent(order));
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color brownDark = Colors.brown.shade700;
    final Color brownLight = Colors.brown.shade400;

    return Scaffold(
      backgroundColor: const Color(0xFFF6EBDD),
      appBar: AppBar(
        backgroundColor: brownDark,
        title: const Text('Place Order'),
        centerTitle: true,
        elevation: 6,
      ),
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
            padding: EdgeInsets.only(top: 135, left: 24),
            child: Text(
              'Shipping Details',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
                shadows: [
                  Shadow(blurRadius: 6, color: Colors.black26, offset: Offset(2, 2)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190, left: 16, right: 16, bottom: 12),
            child: BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderSuccess) {
                  // Clear the cart after successful order placement
                  context.read<CartBloc>().add(ClearCartEvent());

                  // Navigate to success screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderSuccessScreen(userId: '')),
                  );
                } else if (state is OrderFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(
                          controller: _fullNameController,
                          label: 'Full Name',
                          validatorMsg: 'Please enter your name',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                          validatorMsg: 'Please enter your address',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          validatorMsg: 'Please enter your phone number',
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _paymentMethod,
                          decoration: InputDecoration(
                            labelText: 'Payment Method',
                            labelStyle: TextStyle(color: brownDark),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: brownLight),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: brownDark, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                          dropdownColor: Colors.brown[50],
                          items: const [
                            DropdownMenuItem(value: 'cod', child: Text('Cash On Delivery')),
                            // Add other payment methods here
                          ],
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: state is OrderLoading ? null : _submitOrder,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: state is OrderLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Place Order',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final brownDark = Colors.brown.shade700;
    final brownLight = Colors.brown.shade400;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: brownDark),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: brownLight),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: brownDark, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) => (value == null || value.isEmpty) ? validatorMsg : null,
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
