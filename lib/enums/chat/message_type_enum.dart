// ignore_for_file: constant_identifier_names
enum MessageTypeEnum { TEXT, AUDIO, PHOTO, VIDEO, DOCUMENT }

class MessageTypeConverter {
  static String enumToString({required MessageTypeEnum type}) {
    if (type == MessageTypeEnum.TEXT) {
      return 'TEXT';
    } else if (type == MessageTypeEnum.AUDIO) {
      return 'AUDIO';
    } else if (type == MessageTypeEnum.PHOTO) {
      return 'PHOTO';
    } else if (type == MessageTypeEnum.VIDEO) {
      return 'VIDEO';
    } else {
      return 'DOCUMENT';
    }
  }

  static MessageTypeEnum stringToEnum({required String type}) {
    if (type == 'TEXT') {
      return MessageTypeEnum.TEXT;
    } else if (type == 'AUDIO') {
      return MessageTypeEnum.AUDIO;
    } else if (type == 'PHOTO') {
      return MessageTypeEnum.PHOTO;
    } else if (type == 'VIDEO') {
      return MessageTypeEnum.VIDEO;
    } else {
      return MessageTypeEnum.DOCUMENT;
    }
  }
}
