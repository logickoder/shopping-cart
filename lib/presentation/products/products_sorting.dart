import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/extensions.dart';
import '../../data/repository/products_repository.dart';

class ProductsSorting extends StatelessWidget {
  final Function(ProductSort?, bool) onItemClick;

  const ProductsSorting({super.key, required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Sorting',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ...ProductSort.values
                .map(
                  (sort) => [
                    [true, false].map(
                      (ascending) {
                        final title = ascending ? 'Low to High' : 'High to Low';
                        return ListTile(
                          onTap: () => onItemClick(sort, ascending),
                          title: Text('${sort.name.capitalize}: $title'),
                        );
                      },
                    ).toList(),
                  ].expand((element) => element),
                )
                .expand((element) => element)
                .toList(),
            ListTile(
              title: const Text(
                'Clear Sorting',
              ),
              onTap: () => onItemClick(null, false),
            ),
          ],
        ),
      ),
    );
  }
}
