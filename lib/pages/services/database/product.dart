import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String name;
  final String description;
  final String category;
  final int price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['Name'],
      description: json['Description'],
      category: json['Category'],
      price: json['Price'],
      imageUrl: json['image'][0],
    );
  }
}

class ProductService {
  final String apiUrl =
      'https://data.jetadmin.app/projects/eazybnb/prod/airtable_liq9/models/appOnkdQitfidwzqQ_tbl373R2Z13hNK8rB';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer Nfz6K5WBjAsrZSGq93FtHVAuBfhrFasFHBFfbAeP',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
