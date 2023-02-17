import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/extensions.dart';
import 'package:shopping_cart/utils/statics.dart';

import '../../utils/error.dart';
import '../models.dart';
import '../remote/api_client.dart';

class CartRepository extends ChangeNotifier {
  final _controller = StreamController<List<Product>>();
  final List<Product> _products = [];
  Stream<List<Product>> get products => _controller.stream;

  void add(Product product, bool inCart) {
    if (inCart) {
      _products.remove(product);
    } else {
      _products.add(product);
    }
    _controller.sink.add(_products);
    notifyListeners();
  }

  int get count => _products.length;

  bool contains(Product product) {
    return _products.firstWhereOrNull((element) => element.id == product.id) !=
        null;
  }
}
