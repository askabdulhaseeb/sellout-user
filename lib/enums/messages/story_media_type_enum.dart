// ignore_for_file: constant_identifier_names
enum StoryMediaTypeEnum { TEXT, VIDEO, PHOTO }

class StoryMediaTypeConverter {
  static String formEnum(StoryMediaTypeEnum type) {
    if (type == StoryMediaTypeEnum.PHOTO) {
      return 'PHOTO';
    } else if (type == StoryMediaTypeEnum.PHOTO) {
      return 'VIDEO';
    } else {
      return 'TEXT';
    }
  }

  static StoryMediaTypeEnum fromString(String type) {
    if (type == 'PHOTO') {
      return StoryMediaTypeEnum.PHOTO;
    } else if (type == 'VIDEO') {
      return StoryMediaTypeEnum.VIDEO;
    } else {
      return StoryMediaTypeEnum.TEXT;
    }
  }
}
