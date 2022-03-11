import 'package:flutter/material.dart';
import '../database/product_api.dart';
import '../models/product.dart';

class ProdProvider extends ChangeNotifier {
  List<Product> _products = <Product>[];

  List<Product> get products => <Product>[..._products];

  void init() async {
    if (_products.isNotEmpty) return;
    await _load();
    print('Print: product provider, No. of product: ${_products.length}');
  }

  Future<void> refresh() async {
    await _load();
  }

  Future<void> _load() async {
    _products = await ProductAPI().getProducts();
    notifyListeners();
  }
}
