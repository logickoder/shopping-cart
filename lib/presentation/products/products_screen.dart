import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/presentation/products/product_item.dart';
import 'package:shopping_cart/utils/dimens.dart';

import '../../data/models.dart';
import '../../data/repository/products_repository.dart';
import 'products_sorting.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<ProductsRepository>();
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Products'),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onSearch: repository.search,
        actions: [
          IconButton(
            onPressed: () => _showBottomSheet(context, repository),
            icon: const Icon(
              Icons.sort_by_alpha_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
          stream: repository.products,
          initialData: const [],
          builder: (_, snapshot) {
            final List<Product> products = snapshot.data!;
            return RefreshIndicator(
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
                itemBuilder: (_, index) => ProductItem(
                  products[index],
                  key: ValueKey(products[index].id),
                ),
                itemCount: products.length,
              ),
            );
          },
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, ProductsRepository repository) =>
      showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ProductsSorting(
            onItemClick: (sort, ascending) {
              repository.sort(sort, ascending);
              Navigator.pop(ctx);
            },
          );
        },
      );
}
