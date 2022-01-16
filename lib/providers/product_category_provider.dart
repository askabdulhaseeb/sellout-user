import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/prod_sub_category.dart';
import '../models/prod_category.dart';

class ProdCatProvider extends ChangeNotifier {
  ProdCategory? _selectedCat;
  List<ProdSubCategory> _subCategory = <ProdSubCategory>[];
  ProdSubCategory? _selectedSubCat;
  final List<ProdCategory> _cat = <ProdCategory>[
    ProdCategory(
      catID: 'trousers',
      title: 'Trousers',
      subCategories: <ProdSubCategory>[
        ProdSubCategory(catID: 'trousers1', title: 'Trousers1'),
        ProdSubCategory(catID: 'trousers2', title: 'Trousers2'),
        ProdSubCategory(catID: 'trousers3', title: 'Trousers3'),
      ],
    ),
    ProdCategory(
      catID: 'accessories',
      title: 'Accessories',
      subCategories: <ProdSubCategory>[
        ProdSubCategory(catID: 'accessories1', title: 'Accessories1'),
        ProdSubCategory(catID: 'accessories2', title: 'Accessories2'),
        ProdSubCategory(catID: 'accessories3', title: 'Accessories3'),
      ],
    ),
    ProdCategory(
      catID: 'hats',
      title: 'Hats',
      subCategories: <ProdSubCategory>[
        ProdSubCategory(catID: 'hats1', title: 'Hats1'),
        ProdSubCategory(catID: 'hats2', title: 'Hats2'),
        ProdSubCategory(catID: 'hats3', title: 'Hats3'),
      ],
    ),
    ProdCategory(
      catID: 'jewellery',
      title: 'Jewellery',
      subCategories: <ProdSubCategory>[
        ProdSubCategory(catID: 'jewellery1', title: 'Jewellery1'),
        ProdSubCategory(catID: 'jewellery2', title: 'Jewellery2'),
        ProdSubCategory(catID: 'jewellery3', title: 'Jewellery3'),
        ProdSubCategory(catID: 'jewellery4', title: 'Jewellery4'),
        ProdSubCategory(catID: 'jewellery5', title: 'Jewellery5'),
      ],
    ),
  ];

  List<ProdCategory> get category => <ProdCategory>[..._cat];
  List<ProdSubCategory> get subCategory => <ProdSubCategory>[..._subCategory];
  ProdCategory? get selectedCategroy => _selectedCat;
  ProdSubCategory? get selectedSubCategory => _selectedSubCat;

  void updateCatSelection(ProdCategory updatedCategroy) {
    _selectedCat = updatedCategroy;
    _subCategory = updatedCategroy.subCategories;
    _selectedSubCat = null;
    notifyListeners();
  }

  void updateSubCategorySection(ProdSubCategory update) {
    _selectedSubCat = update;
    notifyListeners();
  }
}
