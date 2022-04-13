import 'package:flutter/material.dart';
import '../database/auth_methods.dart';
import '../database/product_api.dart';
import '../enums/product_condition.dart';
import '../models/product.dart';

class ProdProvider extends ChangeNotifier {
  List<Product> _products = <Product>[];
  String? _searchText = '';

  List<Product> get products => <Product>[..._products];

  void init() async {
    if (_products.isNotEmpty) return;
    await _load();
    print('Print: product provider, No. of product: ${_products.length}');
  }

  Future<void> refresh() async {
    await _load();
  }

  Product product(String pid) {
    final int _index =
        _products.indexWhere((Product element) => element.pid == pid);
    return (_index < 0) ? _null() : _products[_index];
  }

  onSearch(String? value) {
    _searchText = value!.toLowerCase();
    notifyListeners();
  }

  List<Product> filterdProducts() {
    List<Product> _tempProducts = <Product>[];
    if (_searchText == null || _searchText!.isEmpty) {
      return <Product>[..._products];
    }
    _tempProducts = _products
        .where((Product element) {
          return (element.title.toLowerCase().contains(_searchText!) ||
              element.description.toLowerCase().contains(_searchText!));
        })
        .cast<Product>()
        .toList();
    return _tempProducts;
  }

  Future<void> _load() async {
    final List<Product> _temp = await ProductAPI().getProducts();
    _products = _temp;
    _products.shuffle();
    notifyListeners();
  }

  Product _null() {
    return Product(
      pid: '0',
      uid: AuthMethods.uid,
      title: AuthMethods.uid,
      prodURL: <ProductURL>[ProductURL(url: '', isVideo: false, index: 0)],
      thumbnail: '',
      condition: ProdConditionEnum.NEW,
      description: 'description',
      categories: <String>[''],
      subCategories: <String>[''],
      price: 0,
    );
  }
}
