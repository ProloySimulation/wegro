import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/models/product.dart';

import '../providers/database_provider.dart';
import '../providers/single_product_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;

  const ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    final singleProductProvider = Provider.of<SingleProductProvider>(context, listen: false);
    final databaseProvider = Provider.of<DatabaseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: FutureBuilder<Product>(
        future: singleProductProvider.fetchProductDetail(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productDetail = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(productDetail.image),
                  SizedBox(height: 16.0),
                  Text(
                    productDetail.title,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \$${productDetail.price}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    productDetail.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Category: ${productDetail.category}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Rating: ${productDetail.rating}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () async {
                      bool isSuccess = await databaseProvider.insertData({
                        'id': productDetail.id,
                        'title': productDetail.title,
                        'image': productDetail.image,
                        'price': productDetail.price,
                        'description': productDetail.description,
                        'category': productDetail.category,
                        'rating': productDetail.rating,
                      });
                      if (isSuccess) {
                        // Insertion successful
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product added to favorites')),
                        );
                      } else {
                        // Insertion failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add product to favorites')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/fav.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
