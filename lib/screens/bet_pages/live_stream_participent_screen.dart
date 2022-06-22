import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/time_date_functions.dart';
import '../../utilities/utilities.dart';

class LiveStreamParticipantScreen extends StatefulWidget {
  const LiveStreamParticipantScreen({required this.channelID, Key? key})
      : super(key: key);
  final String channelID;

  @override
  State<LiveStreamParticipantScreen> createState() =>
      _LiveStreamParticipantScreenState();
}

class _LiveStreamParticipantScreenState
    extends State<LiveStreamParticipantScreen> {
  final List<int> uids = <int>[];
  late RtcEngine _engine;
  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  @override
  void dispose() {
    uids.clear();
    _engine.leaveChannel();
    _engine.destroy();
    _channel?.leave();
    _client?.logout();
    _client?.destroy();
    super.dispose();
  }

  Future<void> initializeAgora() async {
    final int _time = DateTime.now().millisecondsSinceEpoch;
    _engine =
        await RtcEngine.createWithContext(RtcEngineContext(Utilities.agoraID));
    _client = await AgoraRtmClient.createInstance(Utilities.agoraID);
    await _engine.enableVideo(); // to enable the video
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    final int _uuid =
        int.parse(_time.toString().substring(1, _time.toString().length - 3));
    print('Print: _uuid: $_uuid');
    print('Print: Token: ${Utilities.agoraToken}');

    final _resp = await _client?.login(null, '$_uuid'); // 0 -> uid in int
    print('Print: $_resp');
    _channel = await _client?.createChannel(widget.channelID);
    await _channel?.join();
    await _engine.joinChannel(
        null, widget.channelID, null, _uuid); //0 -> uid in int

    // Callback for the RTC engine
    _engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      setState(() {
        uids.add(uid);
      });
      print('Print: uid in Live stream participent: $uid');
    }, leaveChannel: (RtcStats state) {
      setState(() {
        uids.clear();
      });
    }));

    // Callback for the RTC client
    // Messaging
    _client?.onMessageReceived = ((AgoraRtmMessage message, String peerId) {
      print('Private message from $peerId:${message.text}');
    });

    _client?.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: $state, reason:$reason');
      if (state == 5) {
        _channel?.leave();
        _client?.logout();
        _client?.destroy();
        print('Logged out.');
      }
    };

    // Callback for the RTC channel
    _channel?.onMemberJoined = (AgoraRtmMember member) {
      print('Member joined: ${member.userId} , channel:  ${member.channelId}');
    };
    _channel?.onMemberLeft = (AgoraRtmMember member) {
      print('Member left: ${member.userId} channel: ${member.channelId}');
    };
    _channel?.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      //TODO: implement this
      print('Public Message from ${member.userId} - ${message.text}');
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _broadastView(),
        ],
      ),
    );
  }

  Widget _broadastView() {
    return uids.isEmpty
        ? Center(
            child: Text('No User'),
          )
        : Expanded(child: RtcLocalView.SurfaceView());
  }
}

class _ToolBarView extends StatelessWidget {
  const _ToolBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.call),
          shape: CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
        RawMaterialButton(
          onPressed: () {},
          child: Icon(Icons.mic_off),
          shape: CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
      ],
    );
  }
}
