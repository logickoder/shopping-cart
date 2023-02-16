import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/presentation/products/product_item.dart';
import 'package:shopping_cart/utils/dimens.dart';

import '../../data/repository/products_repository.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<ProductsRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: repository.loadFromRemote,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: sPadding,
              horizontal: sPadding / 2,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: sPadding / 4,
              crossAxisSpacing: sPadding / 2,
              childAspectRatio: 1 / 1.5,
            ),
            itemBuilder: (_, index) => ProductItem(repository.products[index]),
            itemCount: repository.products.length,
          ),
        ),
      ),
    );
  }
}
