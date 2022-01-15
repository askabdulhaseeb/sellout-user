import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/prod_sub_category.dart';
import '../models/prod_category.dart';

class ProdCatProvider extends ChangeNotifier {
  ProdCategory? _selectedCat;
  final List<ProdCategory> _cat = <ProdCategory>[
    ProdCategory(
      catID: 'trousers',
      title: 'Trousers',
      subCategories: <ProdSubCategory>[],
    ),
    ProdCategory(
      catID: 'accessories',
      title: 'Accessories',
      subCategories: <ProdSubCategory>[],
    ),
    ProdCategory(
      catID: 'hats',
      title: 'Hats',
      subCategories: <ProdSubCategory>[],
    ),
    ProdCategory(
      catID: 'jewellery',
      title: 'Jewellery',
      subCategories: <ProdSubCategory>[],
    ),
  ];

  List<ProdCategory> get category => <ProdCategory>[..._cat];
  ProdCategory? get selectedCategroy => _selectedCat;
  void updateSelection(ProdCategory updatedCategroy) {
    _selectedCat = updatedCategroy;
    notifyListeners();
  }
}
