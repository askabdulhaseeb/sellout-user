// ignore_for_file: constant_identifier_names
enum ProdPrivacyTypeEnum { PUBLIC, SUPPORTERS, PRIVATE }

class ProdPrivacyTypeEnumConvertor {
  static String enumToString({required ProdPrivacyTypeEnum privacy}) {
    if (privacy == ProdPrivacyTypeEnum.PUBLIC) {
      return 'PUBLIC';
    } else if (privacy == ProdPrivacyTypeEnum.SUPPORTERS) {
      return 'SUPPORTERS';
    } else {
      return 'PRIVATE';
    }
  }

  static ProdPrivacyTypeEnum stringToEnum({required String privacy}) {
    if (privacy == 'PUBLIC') {
      return ProdPrivacyTypeEnum.PUBLIC;
    } else if (privacy == 'SUPPORTERS') {
      return ProdPrivacyTypeEnum.SUPPORTERS;
    } else {
      return ProdPrivacyTypeEnum.PRIVATE;
    }
  }
}
