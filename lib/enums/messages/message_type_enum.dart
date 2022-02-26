// ignore_for_file: constant_identifier_names
enum MessageTypeEnum {
  TEXT,
  AUDIO,
  PHOTO,
  VIDEO,
  PROD_OFFER,
  STORY_REPLY,
  DOCUMENT,
  ANNOUNCEMENT,
}

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
    } else if (type == MessageTypeEnum.PROD_OFFER) {
      return 'PROD_OFFER';
    } else if (type == MessageTypeEnum.STORY_REPLY) {
      return 'STORY_REPLY';
    } else if (type == MessageTypeEnum.DOCUMENT) {
      return 'DOCUMENT';
    } else {
      return 'ANNOUNCEMENT';
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
    } else if (type == 'PROD_OFFER') {
      return MessageTypeEnum.PROD_OFFER;
    } else if (type == 'STORY_REPLY') {
      return MessageTypeEnum.STORY_REPLY;
    } else if (type == 'DOCUMENT') {
      return MessageTypeEnum.DOCUMENT;
    } else {
      return MessageTypeEnum.ANNOUNCEMENT;
    }
  }
}
