import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/main_bottom_nav_bar_provider.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    required String videoUrl,
    this.isMute = true,
    this.isPause = false,
    Key? key,
  })  : _videoUrl = videoUrl,
        super(key: key);
  final String _videoUrl;
  final bool isMute;
  final bool isPause;
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget._videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(widget.isMute ? 0 : 1)
      ..initialize().then(
        (_) => widget.isPause ? _controller?.pause() : _controller?.play(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        VideoPlayer(_controller!),
        (widget.isPause)
            ? const Padding(
                padding: EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.video_collection_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              )
            : Consumer<AppProvider>(
                builder: (_, AppProvider volumm, __) => InkWell(
                  onTap: () {
                    volumm.toggleMuteButton();
                    _controller!.setVolume(volumm.isMute ? 0 : 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: volumm.isMute
                          ? const Icon(Icons.volume_off_sharp,
                              color: Colors.black)
                          : const Icon(Icons.volume_up, color: Colors.black),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
