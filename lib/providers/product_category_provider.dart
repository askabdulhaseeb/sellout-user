import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/product_category.dart';

class ProdCatProvider extends ChangeNotifier {
  ProdCategory? _selectedCat;
  final List<ProdCategory> _cat = <ProdCategory>[
    ProdCategory(catID: 'trousers', title: 'Trousers'),
    ProdCategory(catID: 'accessories', title: 'Accessories'),
    ProdCategory(catID: 'hats', title: 'Hats'),
    ProdCategory(catID: 'jewellery', title: 'Jewellery'),
  ];

  List<ProdCategory> get category => <ProdCategory>[..._cat];
  ProdCategory? get selectedCategroy => _selectedCat;
  void updateSelection(ProdCategory updatedCategroy) {
    _selectedCat = updatedCategroy;
    notifyListeners();
  }
}
