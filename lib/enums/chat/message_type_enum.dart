// ignore_for_file: constant_identifier_names
enum MessageTypeEnum { TEXT, AUDIO, PHOTO, VIDEO }

class MessageTypeConverter {
  static String enumToString({required MessageTypeEnum type}) {
    if (type == MessageTypeEnum.TEXT) {
      return 'TEXT';
    } else if (type == MessageTypeEnum.AUDIO) {
      return 'AUDIO';
    } else if (type == MessageTypeEnum.PHOTO) {
      return 'PHOTO';
    } else {
      return 'VIDEO';
    }
  }

  static MessageTypeEnum stringToEnum({required String type}) {
    if (type == 'TEXT') {
      return MessageTypeEnum.TEXT;
    } else if (type == 'AUDIO') {
      return MessageTypeEnum.AUDIO;
    } else if (type == 'PHOTO') {
      return MessageTypeEnum.PHOTO;
    } else {
      return MessageTypeEnum.VIDEO;
    }
  }
}
