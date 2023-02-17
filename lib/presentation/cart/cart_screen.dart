import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/presentation/cart/cart_item.dart';
import 'package:shopping_cart/presentation/widgets/product_item.dart';
import 'package:shopping_cart/utils/dimens.dart';

import '../../data/models.dart';
import '../../data/repository/cart_repository.dart';
import '../../utils/formatters.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cart = context.watch<CartRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            vertical: sPadding,
            horizontal: sPadding / 2,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: theme.textTheme.headlineSmall,
                ),
                Consumer<CartRepository>(
                  builder: (_, cart, __) {
                    return Text(
                      format(cart.total),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
            ...cart.items.map(
              (item) {
                return SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ProductItem(
                    product: item.product,
                    key: ValueKey(item.product.id),
                    control: SizedBox(
                      width: double.infinity,
                      child: Consumer<CartRepository>(
                        builder: (_, cart, __) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => cart.update(
                                  item.product.id,
                                  item.count - 1,
                                ),
                                child: const Icon(Icons.remove),
                              ),
                              Text(item.count.toString()),
                              ElevatedButton(
                                onPressed: () => cart.update(
                                  item.product.id,
                                  item.count + 1,
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
