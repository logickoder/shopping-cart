import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models.dart';
import '../../data/repository/cart_repository.dart';
import '../../utils/dimens.dart';
import '../../utils/formatters.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Widget control;

  const ProductItem({Key? key, required this.product, required this.control})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sRadius),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(sPadding / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(sRadius),
                    topRight: Radius.circular(sRadius),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: sPadding),
              SizedBox(
                width: double.infinity,
                child: Text(
                  product.title,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  format(product.price),
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Rating: ${product.rating.rate}",
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: sPadding / 2),
              control,
            ],
          ),
        ),
      ),
    );
  }
}
