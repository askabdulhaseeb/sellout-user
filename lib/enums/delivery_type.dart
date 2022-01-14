// ignore_for_file: constant_identifier_names
enum DeliveryTypeEnum { DELIVERY, COLLOCATION, BOTH }

class DeliveryTypeEnumConvertor {
  static String enumToString({required DeliveryTypeEnum delivery}) {
    if (delivery == DeliveryTypeEnum.DELIVERY) {
      return 'DELIVERY';
    } else if (delivery == DeliveryTypeEnum.COLLOCATION) {
      return 'COLLOCATION';
    } else {
      return 'BOTH';
    }
  }

  static DeliveryTypeEnum stringToEnum({required String delivery}) {
    if (delivery == 'DELIVERY') {
      return DeliveryTypeEnum.DELIVERY;
    } else if (delivery == 'COLLOCATION') {
      return DeliveryTypeEnum.COLLOCATION;
    } else {
      return DeliveryTypeEnum.BOTH;
    }
  }
}
