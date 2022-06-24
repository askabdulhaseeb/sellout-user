import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../database/auth_methods.dart';
import '../../models/auction.dart';
import '../../utilities/utilities.dart';

class LiveStreamParticipantScreen extends StatefulWidget {
  const LiveStreamParticipantScreen({required this.auction, Key? key})
      : super(key: key);
  final Auction auction;

  @override
  State<LiveStreamParticipantScreen> createState() =>
      _LiveStreamParticipantScreenState();
}

class _LiveStreamParticipantScreenState
    extends State<LiveStreamParticipantScreen> {
  final List<int> _users = <int>[];
  String chID = '';
  int remoteUid = 0;
  bool isJoined = false;
  late RtcEngine engine;
  ClientRole role = ClientRole.Broadcaster;

  @override
  void initState() {
    super.initState();
    setLiveMode();
  }

  @override
  void dispose() {
    engine.destroy();
    super.dispose();
  }

  Future<void> setLiveMode() async {
    String hostLive = widget.auction.uid;
    if (hostLive == AuthMethods.uid) {
      role = ClientRole.Broadcaster;
    } else {
      role = ClientRole.Audience;
    }
    await startBroadcast();
  }

  Future<void> startBroadcast() async {
    await [Permission.camera, Permission.microphone].request();

    engine =
        await RtcEngine.createWithContext(RtcEngineContext(Utilities.agoraID));

    engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, _) =>
            joinChannel(channel, uid),
        userJoined: (int uid, _) => join(uid),
        userOffline: (int uid, UserOfflineReason reason) => leave(uid),
      ),
    );

    await engine.enableVideo();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(role);
    await engine.joinChannel(
        Utilities.agoraToken, AuthMethods.uid, null, 123456789);
  }

  joinChannel(String channel, int uid) {
    print('Print: channal id: $channel');
    chID = channel;
    _users.add(uid);
    setState(() => isJoined = true);
  }

  join(int uid) {
    _users.add(uid);
    setState(() => remoteUid = uid);
  }

  leave(int uid) {
    _users.remove(uid);
    setState(() => remoteUid = 0);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (role == ClientRole.Broadcaster)
          ? _renderLocalPreview()
          : _renderRemoteVideo(),
    );
  }

  Widget _renderLocalPreview() {
    if (isJoined) {
      return const rtc_local_view.SurfaceView();
    } else {
      return const Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (remoteUid != 0) {
      return rtc_remote_view.SurfaceView(
        channelId: chID,
        uid: remoteUid,
        mirrorMode: VideoMirrorMode.Enabled,
        renderMode: VideoRenderMode.Fit,
      );
    } else {
      return const Text(
        'Please wait remote user join',
      );
    }
  }
}

// ignore: unused_element
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
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.call),
        ),
        RawMaterialButton(
          onPressed: () {},
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.mic_off),
        ),
      ],
    );
  }
}
