import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/statics.dart';

import '../../utils/error.dart';
import '../models.dart';
import '../remote/api_client.dart';

class ProductsRepository extends ChangeNotifier {
  static const _key = 'products';
  final ApiService _service = ApiService.instance;

  List<Product> _products = [];
  List<Product> get products => _products;

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
    notifyListeners();
  }
}
