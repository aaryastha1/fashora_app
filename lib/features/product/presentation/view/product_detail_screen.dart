import 'package:flutter/material.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  // Add your backend base URL here (adjust if needed)
  final String backendBaseUrl = 'http://10.0.2.2:5006';

  ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Gradient buttonGradient = LinearGradient(
      colors: [const Color.fromARGB(255, 205, 123, 227), Colors.pink.shade400],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Build full image URL if needed
    String imageUrl = product.image.startsWith('http')
        ? product.image
        : (product.image.isNotEmpty ? '$backendBaseUrl/uploads/${product.image}' : '');

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.pink.shade400,
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
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                                child: Icon(Icons.broken_image,
                                    size: 50, color: Colors.grey)),
                      )
                    : const Center(
                        child: Icon(Icons.image_not_supported,
                            size: 50, color: Colors.grey),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Gradient Text for Product Name
            ShaderMask(
              shaderCallback: (bounds) => buttonGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Required for ShaderMask
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              "Rs. ${product.price}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              "In stock: ${product.stock}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Gradient Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: buttonGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // TODO: Add to cart logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                icon:
                    const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
