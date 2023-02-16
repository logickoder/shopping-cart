import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/extensions.dart';
import 'package:shopping_cart/utils/statics.dart';

import '../../utils/error.dart';
import '../models.dart';
import '../remote/api_client.dart';

class ProductsRepository extends ChangeNotifier {
  static const _key = 'products';
  final ApiService _service = ApiService.instance;

  final _controller = StreamController<List<Product>>();
  List<Product> _products = const [];
  Stream<List<Product>> get products => _controller.stream;

  ProductsRepository() {
    _loadFromLocal();
    loadFromRemote();
  }

  Future<void> loadFromRemote() async {
    await _service.client?.getProducts().then((value) {
      box.put(_key, jsonEncode(value));
      _loadFromLocal();
    }).catchError(catchError);
  }

  Future<void> _loadFromLocal() async {
    final String? value = box.get(_key);
    if (value != null) {
      _products = (jsonDecode(value) as List<dynamic>)
          .map((json) => Product.fromJson(json))
          .toList();
    }
    _controller.sink.add(_products);
  }

  void search(String text) {
    if (text.isEmpty) {
      _controller.sink.add(_products);
    } else {
      _controller.sink.add(
        _products.where((product) {
          return product.title.containsIgnoreCase(text) ||
              product.category.containsIgnoreCase(text) ||
              product.description.containsIgnoreCase(text);
        }).toList(),
      );
    }
  }
}
