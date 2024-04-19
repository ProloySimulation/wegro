import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/screens/saved_products_page.dart';
import 'package:wegro/screens/sign_up_page.dart';

import '../providers/product_provider.dart';
import '../widgets/product_item.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage(),
        ),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaveProductPage(),
                    ),
                  );
                  // Handle tap on the first image
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/ic_fav.png',
                    width: 24, // Adjust the width as needed
                    height: 24, // Adjust the height as needed
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _signOut(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/logout.png',
                    width: 24, // Adjust the width as needed
                    height: 24, // Adjust the height as needed
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          if (productProvider.products.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(productId: product.id),
                      ),
                    );
                  },
                  child: ProductItem(product: product),
                );
              },
            );
          }
        },
      ),
    );
  }
}
