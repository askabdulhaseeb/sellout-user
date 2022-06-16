import 'package:cloud_firestore/cloud_firestore.dart';
import '../enums/delivery_type.dart';
import '../enums/privacy_type.dart';
import '../enums/product_condition.dart';

class ProductURL {
  ProductURL({
    required this.url,
    required this.isVideo,
    required this.index,
  });

  final String url;
  final bool isVideo;
  final int index;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'is_video': isVideo,
      'index': index,
    };
  }

  // ignore: sort_constructors_first
  factory ProductURL.fromMap(Map<String, dynamic> map) {
    return ProductURL(
      url: map['url'] ?? '',
      isVideo: map['is_video'] ?? false,
      index: map['index']?.toInt() ?? 0,
    );
  }
}

class Product {
  Product({
    required this.pid,
    required this.uid,
    required this.title,
    required this.prodURL,
    required this.thumbnail,
    required this.condition,
    required this.description,
    required this.categories,
    required this.subCategories,
    required this.price,
    this.location,
    this.quantity = 1,
    this.acceptOffers = true,
    this.privacy = ProdPrivacyTypeEnum.PUBLIC,
    this.delivery = DeliveryTypeEnum.DELIVERY,
    this.deliveryFree = 0,
    this.timestamp,
    this.isAvailable = true,
  });

  late String pid;
  late String uid;
  late String title;
  late List<ProductURL> prodURL;
  late String thumbnail;
  late ProdConditionEnum condition;
  late String description;
  late List<String> categories;
  late List<String> subCategories;
  late double price;
  late String? location;
  late int quantity;
  late bool acceptOffers;
  late ProdPrivacyTypeEnum privacy;
  late DeliveryTypeEnum delivery;
  late double deliveryFree;
  late int? timestamp;
  late bool isAvailable; // available for sale any more are not

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'title': title,
      'prodURL': prodURL.map((ProductURL e) => e.toMap()).toList(),
      'thumbnail': thumbnail,
      'condition':
          ProdConditionEnumConvertor.enumToString(condition: condition),
      'description': description,
      'categories': categories,
      'sub_categories': subCategories,
      'price': price,
      'quantity': quantity,
      'accept_offers': acceptOffers,
      'privacy': ProdPrivacyTypeEnumConvertor.enumToString(privacy: privacy),
      'delivery': DeliveryTypeEnumConvertor.enumToString(delivery: delivery),
      'delivery_free': deliveryFree,
      'timestamp': timestamp,
      'is_available': isAvailable,
    };
  }

  // ignore: sort_constructors_first
  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<ProductURL> prodURL = <ProductURL>[];
    doc.data()!['prodURL'].forEach((dynamic e) {
      prodURL.add(ProductURL.fromMap(e));
    });
    return Product(
      pid: doc.data()!['pid'] ?? '',
      uid: doc.data()!['uid'] ?? '',
      title: doc.data()!['title'] ?? '',
      prodURL: prodURL,
      thumbnail: doc.data()!['thumbnail'] ?? '',
      condition: ProdConditionEnumConvertor.stringToEnum(
          condition: doc.data()!['condition']),
      description: doc.data()!['description'] ?? '',
      categories: List<String>.from(doc.data()!['categories']),
      subCategories: List<String>.from(doc.data()!['sub_categories']),
      price: doc.data()!['price']?.toDouble() ?? 0.0,
      location: doc.data()!['location'] ?? 'location not found',
      quantity: doc.data()!['quantity']?.toInt() ?? 0,
      acceptOffers: doc.data()!['accept_offers'] ?? false,
      privacy: ProdPrivacyTypeEnumConvertor.stringToEnum(
          privacy: doc.data()!['privacy']),
      delivery: DeliveryTypeEnumConvertor.stringToEnum(
          delivery: doc.data()!['delivery']),
      deliveryFree: doc.data()!['delivery_free']?.toDouble() ?? 0.0,
      timestamp: doc.data()!['timestamp']?.toInt(),
      isAvailable: doc.data()!['is_available'] ?? false,
    );
  }
}
