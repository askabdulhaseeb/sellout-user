import 'package:cloud_firestore/cloud_firestore.dart';
import 'prod_sub_category.dart';

class ProdCategory {
  ProdCategory({
    required this.catID,
    required this.title,
    required this.subCategories,
  });

  final String catID;
  final String title;
  final List<ProdSubCategory> subCategories;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cat_id': catID,
      'title': title,
      'sub_categories':
          subCategories.map((ProdSubCategory x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory ProdCategory.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProdCategory(
      catID: doc.data()!['cat_id'] ?? '',
      title: doc.data()!['title'] ?? '',
      subCategories: List<ProdSubCategory>.from(doc
          .data()!['sub_categories']
          ?.map((Map<String, dynamic> x) => ProdSubCategory.fromMap(x))),
    );
  }
}
