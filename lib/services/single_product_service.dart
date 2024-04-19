import 'package:wegro/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SingleProductService {
  static Future<Product> fetchProductDetail(int productId) async {
    final response =
    await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));
    if (response.statusCode == 200) {
      final productDetailJson = json.decode(response.body);
      final productDetail = Product.fromJson(productDetailJson);
      return productDetail;
    } else {
      throw Exception('Failed to load product detail');
    }
  }
}