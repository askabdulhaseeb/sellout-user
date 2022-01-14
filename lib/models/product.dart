import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellout/enums/delivery_type.dart';
import 'package:sellout/enums/privacy_type.dart';
import 'package:sellout/enums/product_condition.dart';
import 'package:sellout/models/product_category.dart';

class Product {
  Product({
    required this.pid,
    required this.uid,
    required this.images,
    required this.condition,
    required this.description,
    required this.category,
    required this.price,
    this.quantity = 1,
    this.acceptOffers = true,
    this.privacy = ProdPrivacyTypeEnum.PUBLIC,
    this.delivery = DeliveryTypeEnum.DELIVERY,
    this.deliveryFree = 0,
    this.timestamp,
    this.isAvailable = true,
  });

  final String pid;
  final String uid;
  final List<String> images;
  final ProdConditionEnum condition;
  final String description;
  final List<ProdCategory> category;
  final double price;
  final int quantity;
  final bool acceptOffers;
  final ProdPrivacyTypeEnum privacy;
  final DeliveryTypeEnum delivery;
  final double deliveryFree;
  final int? timestamp;
  final bool isAvailable; // available for sale any more are not

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'images': images,
      'condition':
          ProdConditionEnumConvertor.enumToString(condition: condition),
      'description': description,
      'category': category.map((ProdCategory x) => x.toMap()).toList(),
      'price': price,
      'quantity': quantity,
      'acceptOffers': acceptOffers,
      'privacy': ProdPrivacyTypeEnumConvertor.enumToString(privacy: privacy),
      'delivery': DeliveryTypeEnumConvertor.enumToString(delivery: delivery),
      'deliveryFree': deliveryFree,
      'timestamp': timestamp,
      'isAvailable': isAvailable,
    };
  }

  // ignore: sort_constructors_first
  factory Product.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
      pid: doc.data()!['pid'] ?? '',
      uid: doc.data()!['uid'] ?? '',
      images: List<String>.from(doc.data()!['images']),
      condition: ProdConditionEnumConvertor.stringToEnum(
          condition: doc.data()!['condition']),
      description: doc.data()!['description'] ?? '',
      category: List<ProdCategory>.from(
          doc.data()!['category']((dynamic x) => ProdCategory.fromDoc(x))),
      price: doc.data()!['price']?.toDouble() ?? 0.0,
      quantity: doc.data()!['quantity']?.toInt() ?? 0,
      acceptOffers: doc.data()!['acceptOffers'] ?? false,
      privacy: ProdPrivacyTypeEnumConvertor.stringToEnum(
          privacy: doc.data()!['privacy']),
      delivery: DeliveryTypeEnumConvertor.stringToEnum(
          delivery: doc.data()!['delivery']),
      deliveryFree: doc.data()!['deliveryFree']?.toDouble() ?? 0.0,
      timestamp: doc.data()!['timestamp']?.toInt(),
      isAvailable: doc.data()!['isAvailable'] ?? false,
    );
  }
}
