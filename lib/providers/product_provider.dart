import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier{
  List<Product> _products = [];
  List<Product> get products => _products;

  ProductProvider() {
    fetchAndSetProducts(); // Call the fetchAndSetProducts method when the ProductProvider is created
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final fetchedProducts = await ProductService.fetchProducts();
      _products = fetchedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}