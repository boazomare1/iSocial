// ignore_for_file: library_private_types_in_public_api

import 'package:demo/pages/services/database/product.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> productsFuture;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    productsFuture = productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.category),
                  onTap: () {
                    // Navigate to product details page (bonus feature)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Image.network(product.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(product.description),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Price: \$${product.price}'),
          ),
        ],
      ),
    );
  }
}

