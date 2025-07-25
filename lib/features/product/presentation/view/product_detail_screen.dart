
import 'package:fashora_app/features/cart/presentation/view_model/cart_event.dart';
import 'package:fashora_app/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;
  final String backendBaseUrl = 'http://10.0.2.2:5006';

  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Gradient buttonGradient = LinearGradient(
      colors: [
 const Color.fromARGB(218, 141, 93, 5),
     const Color.fromARGB(102, 189, 110, 6)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    String imageUrl = product.image.startsWith('http')
        ? product.image
        : (product.image.isNotEmpty ? '$backendBaseUrl/uploads/${product.image}' : '');

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: buttonGradient),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) => buttonGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                product.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text("Rs. ${product.price}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 16, height: 1.5)),
            const SizedBox(height: 30),

            // ✅ Add to Cart Button (no navigation)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(gradient: buttonGradient, borderRadius: BorderRadius.circular(12)),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
         onPressed: () {
  if (product.id != null) {
    BlocProvider.of<CartBloc>(context).add(AddToCartEvent(product.id!));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "✅ Added to cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
      ),
    );
  }
},

                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                label: const Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
