import 'package:flutter/material.dart';

import 'cart/cart_screen.dart';
import 'products/products_screen.dart';

class Routes {
  static const products = '/';
  static const cart = '/cart';

  static Map<String, Widget Function(BuildContext)> get routes {
    return {
      products: (_) => const ProductsScreen(),
      cart: (_) => const CartScreen(),
    };
  }
}
