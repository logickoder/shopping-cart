import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/presentation/cart/cart_item.dart';
import 'package:shopping_cart/presentation/widgets/product_item.dart';
import 'package:shopping_cart/utils/dimens.dart';

import '../../data/models.dart';
import '../../data/repository/cart_repository.dart';
import '../../data/repository/products_repository.dart';
import '../routes.dart';
import 'products_sorting.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<ProductsRepository>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Products'),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onSearch: repository.search,
        actions: [
          Badge(
            alignment: const AlignmentDirectional(sPadding, 0),
            label: Consumer<CartRepository>(
              builder: (_, cart, __) => Text(
                cart.count.toString(),
              ),
            ),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.cart),
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
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
                itemBuilder: (_, index) {
                  final product = snapshot.data![index];
                  return ProductItem(
                    product: product,
                    key: ValueKey(product.id),
                    control: SizedBox(
                      width: double.infinity,
                      child: Consumer<CartRepository>(
                        builder: (_, cart, __) {
                          final inCart = cart.contains(product.id);
                          final title =
                              inCart ? 'Remove from Cart' : 'Add to Cart';
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inCart
                                  ? theme.colorScheme.onSurfaceVariant
                                  : null,
                            ),
                            onPressed: () => inCart
                                ? cart.remove(product.id)
                                : cart.add(snapshot.data!, product.id),
                            child: FittedBox(
                              child: Text(title),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
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
