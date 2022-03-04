import '../database/auth_methods.dart';
import '../enums/messages/role_in_chat_group.dart';

class GroupChatParticipant {
  GroupChatParticipant({
    required this.uid,
    required this.role,
    this.addedBy = '',
    this.isMute = false,
    this.invitationAccepted = true,
  });
  final String uid;
  final GroupParticipantRoleTypeEnum role;
  final String addedBy;
  final bool isMute;
  final bool invitationAccepted;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'role': GroupParticipantRoleTypeConverter.formEnum(role),
      'isMute': isMute,
      'invitation_accepted': invitationAccepted,
      'added_by': addedBy,
    };
  }

  // ignore: sort_constructors_first
  factory GroupChatParticipant.fromMap(Map<String, dynamic> map) {
    return GroupChatParticipant(
      uid: map['uid'] ?? '',
      role:
          GroupParticipantRoleTypeConverter.fromString(map['role'] ?? 'MEMBER'),
      isMute: map['isMute'] ?? false,
      invitationAccepted: map['invitation_accepted'] ?? false,
      addedBy: map['added_by'] ?? AuthMethods.uid,
    );
  }
}
