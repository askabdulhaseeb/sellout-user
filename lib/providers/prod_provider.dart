import 'package:flutter/material.dart';
import 'package:sellout/enums/delivery_type.dart';
import 'package:sellout/enums/privacy_type.dart';
import 'package:sellout/enums/product_condition.dart';
import 'package:sellout/models/prod_category.dart';
import 'package:sellout/models/prod_sub_category.dart';
import 'package:sellout/models/product.dart';
import 'package:sellout/services/user_local_data.dart';

class ProdProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  Product _product = Product(
    pid: DateTime.now().hour.toString() +
        DateTime.now().year.toString() +
        UserLocalData.getUID +
        DateTime.now().month.toString() +
        DateTime.now().day.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString(),
    uid:
        UserLocalData.getUID + DateTime.now().microsecondsSinceEpoch.toString(),
        title: '',
    prodURL: <ProductURL>[],
    thumbnail: '',
    condition: ProdConditionEnum.NEW,
    description: '',
    categories: <String>[],
    subCategories: <String>[],
    price: 0,
  );

  Product get product => _product;

  reset() {
    _product = Product(
      pid: DateTime.now().hour.toString() +
          DateTime.now().year.toString() +
          UserLocalData.getUID +
          DateTime.now().month.toString() +
          DateTime.now().day.toString() +
          DateTime.now().minute.toString() +
          DateTime.now().second.toString(),
      uid: UserLocalData.getUID +
          DateTime.now().microsecondsSinceEpoch.toString(),
      prodURL: <ProductURL>[],
      title: '',
      thumbnail: '',
      condition: ProdConditionEnum.NEW,
      description: '',
      categories: <String>[],
      subCategories: <String>[],
      price: 0,
    );
    notifyListeners();
  }

  updateProdURL(List<ProductURL> update) {
    _product.prodURL = update;
    notifyListeners();
  }

  updateThumbnail(String update) {
    _product.thumbnail = update;
    notifyListeners();
  }

  updateCondition(ProdConditionEnum update) {
    _product.condition = update;
    notifyListeners();
  }

  updateDescription(String update) {
    _product.description = update;
    notifyListeners();
  }

  updateCategory(List<ProdCategory> update) {
    _product.categories = <String>[];
    for (ProdCategory element in update) {
      _product.categories.add(element.catID);
    }
    notifyListeners();
  }

  updateSubCategory(List<ProdSubCategory> update) {
    _product.subCategories = <String>[];
    for (ProdSubCategory element in update) {
      _product.subCategories.add(element.catID);
    }
    notifyListeners();
  }

  updatePrice(double update) {
    _product.price = update;
    notifyListeners();
  }

  updateQuantity(int update) {
    _product.quantity = update;
    notifyListeners();
  }

  updateAcceptOffer(bool update) {
    _product.acceptOffers = update;
    notifyListeners();
  }

  updatePrivacy(ProdPrivacyTypeEnum update) {
    _product.privacy = update;
    notifyListeners();
  }

  updateDelivery(DeliveryTypeEnum update) {
    _product.delivery = update;
    notifyListeners();
  }

  updateDeliveryFee(double update) {
    _product.deliveryFree = update;
    notifyListeners();
  }

  updateTimestamp(int update) {
    _product.timestamp = update;
    notifyListeners();
  }

  updateAbailable(bool update) {
    _product.isAvailable = update;
    notifyListeners();
  }
}
