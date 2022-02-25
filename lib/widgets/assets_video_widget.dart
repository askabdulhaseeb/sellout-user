import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AssetsVideoWidget extends StatefulWidget {
  const AssetsVideoWidget({required String videoPath, Key? key})
      : _videoUrl = videoPath,
        super(key: key);
  final String _videoUrl;

  @override
  _AssetsVideoWidgetState createState() => _AssetsVideoWidgetState();
}

class _AssetsVideoWidgetState extends State<AssetsVideoWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget._videoUrl))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => _controller?.play());
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller!);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
