import 'package:flutter/material.dart';
import '../database/auth_methods.dart';
import '../database/product_api.dart';
import '../enums/delivery_type.dart';
import '../enums/prod_sort_enum.dart';
import '../enums/product_condition.dart';
import '../models/product.dart';

class ProdProvider extends ChangeNotifier {
  List<Product> _products = <Product>[];

  // filters
  ProdSortEnum _sort = ProdSortEnum.bestMatch;
  double _minPrice = 0;
  double _maxPrice = -1;
  ProdConditionEnum? _condition;
  DeliveryTypeEnum? _deliveryType;

  String? _searchText = '';

  List<Product> get products => <Product>[..._products];
  ProdSortEnum get prodSort => _sort;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;
  ProdConditionEnum? get condition => _condition;
  DeliveryTypeEnum? get deliveryType => _deliveryType;

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

  List<Product> filteredProduct() {
    List<Product> _temp = <Product>[];

    return _temp;
  }

  onSearch(String? value) {
    _searchText = value!.toLowerCase();
    notifyListeners();
  }

  onMinPriceUpdate(String? value) {
    _minPrice = double.parse(value ?? '0');
  }

  onMaxPriceUpdate(String? value) {
    _maxPrice = double.parse(value ?? '0');
  }

  resetPrice() {
    _minPrice = 0;
    _maxPrice = -1;
    notifyListeners();
  }

  onSortUpdate(ProdSortEnum? value) {
    _sort = value ?? ProdSortEnum.bestMatch;
    notifyListeners();
  }

  onConditionUpdate(ProdConditionEnum? value) {
    _condition = value;
    notifyListeners();
  }

  onDeliveryUpdate(DeliveryTypeEnum? value) {
    _deliveryType = value;
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
