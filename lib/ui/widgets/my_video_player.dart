// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_flutter/utils/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideoPlayer extends StatefulWidget {
  final String movieId;

  const MyVideoPlayer({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Center(
            child: SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 20,
            ),
          )
        : YoutubePlayer(
            controller: _controller!,
          );
  }
}
