import 'package:flutter/cupertino.dart';
import 'package:wegro/models/product.dart';

import '../services/single_product_service.dart';

class SingleProductProvider extends ChangeNotifier {

 /* SingleProductProvider(){
    fetchProductDetail(1);
  }*/

  Future<Product> fetchProductDetail(int productId) async {
    return await SingleProductService.fetchProductDetail(productId);
  }
}