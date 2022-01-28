// ignore_for_file: constant_identifier_names
enum GroupParticipantRoleTypeEnum { ADMIN, MEMBER }

class GroupParticipantRoleTypeConverter {
  static String formEnum(GroupParticipantRoleTypeEnum role) {
    if (role == GroupParticipantRoleTypeEnum.ADMIN) {
      return 'ADMIN';
    } else {
      return 'MEMBER';
    }
  }

  static GroupParticipantRoleTypeEnum fromString(String role) {
    if (role == 'ADMIN') {
      return GroupParticipantRoleTypeEnum.ADMIN;
    } else {
      return GroupParticipantRoleTypeEnum.MEMBER;
    }
  }
}
