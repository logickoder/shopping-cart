import 'package:flutter/material.dart';

import '../../data/models.dart';
import '../../utils/dimens.dart';
import '../../utils/formatters.dart';

class ProductItem extends StatelessWidget {
  final Product _product;

  const ProductItem(this._product, {Key? key}) : super(key: key);

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
                  child: Image.network(
                    _product.image,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: sPadding),
              SizedBox(
                width: double.infinity,
                child: Text(
                  _product.title,
                  style: theme.textTheme.bodyLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  format(_product.price),
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Rating: ${_product.rating.rate}",
                  style: theme.textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
