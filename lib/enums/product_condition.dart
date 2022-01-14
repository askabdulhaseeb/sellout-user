// ignore_for_file: constant_identifier_names
enum ProdConditionEnum { NEW, USED }

class ProdConditionEnumConvertor {
  static String enumToString({required ProdConditionEnum condition}) {
    if (condition == ProdConditionEnum.NEW) {
      return 'NEW';
    } else {
      return 'USED';
    }
  }

  static ProdConditionEnum stringToEnum({required String condition}) {
    if (condition == 'NEW') {
      return ProdConditionEnum.NEW;
    } else {
      return ProdConditionEnum.USED;
    }
  }
}
