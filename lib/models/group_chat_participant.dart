import '../enums/messages/role_in_chat_group.dart';
import 'app_user.dart';

class GroupChatParticipant {
  GroupChatParticipant({
    required this.user,
    required this.role,
    this.addedBy = '',
    this.isMute = false,
    this.invitationAccepted = true,
  });
  final AppUser user;
  final GroupParticipantRoleTypeEnum role;
  final String addedBy;
  final bool isMute;
  final bool invitationAccepted;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.uid,
      'role': GroupParticipantRoleTypeConverter.formEnum(role),
      'isMute': isMute,
      'invitation_accepted': invitationAccepted,
      'added_by': addedBy,
    };
  }

  // ignore: sort_constructors_first
  factory GroupChatParticipant.fromMap(Map<String, dynamic> map) {
    return GroupChatParticipant(
      user: AppUser.fromMap(map['user']),
      role: GroupParticipantRoleTypeConverter.fromString(map['role']),
      isMute: map['isMute'],
      invitationAccepted: map['invitation_accepted'],
      addedBy: map['added_by'],
    );
  }
}
