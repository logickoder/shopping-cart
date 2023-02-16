import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/statics.dart';

import '../../utils/error.dart';
import '../models.dart';
import '../remote/api_client.dart';

class ProductRepository extends ChangeNotifier {
  static const _key = 'products';
  final ApiService _service = ApiService.instance;

  List<Product> _products = [];
  List<Product> get products => _products;

  ProductRepository() {
    _loadFromLocal();
    _loadFromRemote();
  }

  Future<void> _loadFromRemote() async {
    await _service.client?.getProducts().then((value) {
      box.put(_key, value);
      _loadFromLocal();
    }).catchError(catchError);
  }

  Future<void> _loadFromLocal() async {
    _products = box.get(_key, defaultValue: []);
    notifyListeners();
  }
}
