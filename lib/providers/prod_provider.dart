import 'package:flutter/material.dart';
import '../database/product_api.dart';
import '../models/product.dart';

class ProdProvider extends ChangeNotifier {
  List<Product> _products = <Product>[];
  String? _searchText = '';

  List<Product> get products => <Product>[..._products];

  List<Product> filterdProducts() {
    List<Product> _tempProducts = <Product>[];
    if (_searchText == null || _searchText!.isEmpty) {
      return <Product>[..._products];
    }
    _tempProducts = _products
        .where((element) {
          return (element.title.toLowerCase().contains(_searchText!) ||
              element.description.toLowerCase().contains(_searchText!));
        })
        .cast<Product>()
        .toList();
    return _tempProducts;
  }

  void init() async {
    if (_products.isNotEmpty) return;
    await _load();
    print('Print: product provider, No. of product: ${_products.length}');
  }

  Future<void> refresh() async {
    await _load();
  }

  onSearch(String? value) {
    _searchText = value!.toLowerCase();
    notifyListeners();
  }

  Future<void> _load() async {
    _products = await ProductAPI().getProducts();
    notifyListeners();
  }
}
