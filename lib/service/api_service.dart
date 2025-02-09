import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';


class ApiService {
  final String url = 'https://dummyjson.com/products';

  Future<List<ProductElement>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ProductElement> products = (data['products'] as List)
          .map((productJson) => ProductElement.fromJson(productJson))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
