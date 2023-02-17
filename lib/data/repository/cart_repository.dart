import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../presentation/cart/cart_item.dart';
import '../models.dart';

class CartRepository extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  void add(List<Product> products, int productId) {
    _items.add(
      CartItem(
        product: products.firstWhere((element) => element.id == productId),
        count: 1,
      ),
    );
    notifyListeners();
  }

  void remove(int productId) {
    _items.removeWhere((element) => element.product.id == productId);
    notifyListeners();
  }

  void update(int productId, int count) {
    final index = _items.indexWhere(
      (element) => element.product.id == productId,
    );
    if (count <= 0) {
      remove(productId);
    } else if (index > -1) {
      _items[index] = CartItem(product: _items[index].product, count: count);
      notifyListeners();
    }
  }

  int get count => _items.length;

  double get total {
    if (_items.isEmpty) {
      return 0;
    } else {
      return _items
          .map((e) => e.product.price * e.count)
          .reduce((a, b) => a + b);
    }
  }

  bool contains(int productId) {
    return _items.firstWhereOrNull((e) => e.product.id == productId) != null;
  }
}
