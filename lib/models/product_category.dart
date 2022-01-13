import 'package:cloud_firestore/cloud_firestore.dart';

class ProdCategory {
  ProdCategory({
    required this.catID,
    required this.title,
  });

  final String catID;
  final String title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'catID': catID, 'title': title};
  }

  // ignore: sort_constructors_first
  factory ProdCategory.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProdCategory(
      catID: doc.data()!['catID'],
      title: doc.data()!['title'],
    );
  }
}
