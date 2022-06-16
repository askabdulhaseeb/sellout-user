import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/auth_methods.dart';
import '../enums/messages/message_type_enum.dart';
import '../enums/messages/role_in_chat_group.dart';
import 'group_chat_participant.dart';

class GroupChat {
  GroupChat({
    this.groupID,
    this.createdBy,
    this.createdDate,
    this.name,
    this.imageURL,
    this.description,
    this.participants,
    this.participantsDetail,
    this.lastMessage,
    this.timestamp,
    this.type,
  });

  final String? groupID;
  final String? createdBy;
  final int? createdDate;
  final String? name;
  final String? imageURL;
  final String? description;
  final List<String>? participants;
  final List<GroupChatParticipant>? participantsDetail;
  String? lastMessage;
  int? timestamp;
  MessageTypeEnum? type;

  Map<String, dynamic> createGroup() {
    int time = DateTime.now().microsecondsSinceEpoch;
    return <String, dynamic>{
      'group_id': '${AuthMethods.uid}$time',
      'created_by': createdBy ?? AuthMethods.uid,
      'created_date': createdDate ?? time,
      'name': name!.trim(),
      'imageURL': imageURL,
      'description': description!.trim(),
      'participants': <String>[AuthMethods.uid],
      'participants_details': <Map<String, dynamic>>[
        GroupChatParticipant(
          role: GroupParticipantRoleTypeEnum.ADMIN,
          uid: AuthMethods.uid,
          addedBy: AuthMethods.uid,
          invitationAccepted: true,
          isMute: false,
        ).toMap()
      ],
      'last_message': lastMessage ?? 'Just create new group',
      'timestamp': timestamp ?? time,
      'type': MessageTypeConverter.enumToString(
        type: type ?? MessageTypeEnum.ANNOUNCEMENT,
      ),
    };
  }

  Map<String, dynamic> updateParticipant() {
    List<Map<String, dynamic>> map = <Map<String, dynamic>>[];
    for (GroupChatParticipant element in participantsDetail!) {
      map.add(element.toMap());
    }
    return <String, dynamic>{
      'participants': participants,
      'participants_details': map,
    };
  }

  Map<String, dynamic> newMessage() {
    return <String, dynamic>{
      'last_message': lastMessage!.trim(),
      'timestamp': timestamp,
      'type': MessageTypeConverter.enumToString(
        type: type ?? MessageTypeEnum.TEXT,
      ),
    };
  }

  // ignore: sort_constructors_first
  factory GroupChat.fromMap(Map<String, dynamic> map) {
    List<GroupChatParticipant> participants = <GroupChatParticipant>[];
    return GroupChat(
      groupID: map['group_id'] ?? '',
      createdBy: map['created_by'] ?? '',
      createdDate: map['created_date'] ?? '',
      name: map['name'] ?? '',
      imageURL: map['imageURL'],
      description: map['description'] ?? '',
      participants: List<String>.from(map['participants']),
      participantsDetail: participants,
      lastMessage: map['last_message'] ?? '',
      timestamp: map['timestamp'] ?? '',
      type: MessageTypeConverter.stringToEnum(type: map['type'] ?? 'TEXT'),
    );
  }

  // ignore: sort_constructors_first
  factory GroupChat.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    List<GroupChatParticipant> participantsDetail = <GroupChatParticipant>[];
    List<dynamic> detail = doc.data()?['participants_details'];
    detail.forEach(
      ((dynamic map) {
        participantsDetail.add(GroupChatParticipant.fromMap(map));
      }),
    );
    return GroupChat(
      groupID: doc.data()?['group_id'] ?? '',
      createdBy: doc.data()?['created_by'] ?? '',
      createdDate: doc.data()?['created_date'] ?? '',
      name: doc.data()?['name'] ?? '',
      imageURL: doc.data()?['imageURL'],
      description: doc.data()?['description'] ?? '',
      participants: List<String>.from(doc.data()?['participants']),
      participantsDetail: participantsDetail,
      lastMessage: doc.data()?['last_message'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? '',
      type: MessageTypeConverter.stringToEnum(
        type: doc.data()?['type'] ?? 'TEXT',
      ),
    );
  }
}
