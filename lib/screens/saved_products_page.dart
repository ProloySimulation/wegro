import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wegro/widgets/saved_product_item.dart';

import '../models/product.dart';
import '../providers/database_provider.dart';
import '../widgets/product_item.dart';

class SaveProductPage extends StatelessWidget {
  const SaveProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Products'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, _) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: databaseProvider.queryData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final savedProducts = snapshot.data!;
                return ListView.builder(
                  itemCount: savedProducts.length,
                  itemBuilder: (context, index) {
                    final product = Product(
                      id: savedProducts[index]['id'],
                      title: savedProducts[index]['title'],
                      price: savedProducts[index]['price'],
                      description: savedProducts[index]['description'],
                      category: savedProducts[index]['category'],
                      image: savedProducts[index]['image'],
                      rating: savedProducts[index]['rating'],
                    );
                    return SavedProductItem(product: product,
                    onRemove: (){
                      databaseProvider.removeData(product.id);
                    },);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
