class ProdSubCategory {
  ProdSubCategory({
    required this.catID,
    required this.title,
  });

  final String catID;
  final String title;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_cat_id': catID,
      'title': title,
    };
  }

  // ignore: sort_constructors_first
  factory ProdSubCategory.fromMap(Map<String, dynamic> map) {
    return ProdSubCategory(
      catID: map['sub_cat_id'] ?? '',
      title: map['title'] ?? '',
    );
  }
}
