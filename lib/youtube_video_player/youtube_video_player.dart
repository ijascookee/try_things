import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_youtube_player/the_youtube_player.dart';

class YoutubeVideoPlayerPage extends StatefulWidget {
  const YoutubeVideoPlayerPage({super.key});

  @override
  State<YoutubeVideoPlayerPage> createState() => _YoutubeVideoPlayerPageState();
}

class _YoutubeVideoPlayerPageState extends State<YoutubeVideoPlayerPage> {
  // final _controller = TheYoutubePlayerController.fromVideoId(
  //   videoId: 'EdsC5J-FzJ8',
  //   autoPlay: false,
  //   params: const YoutubePlayerParams(
  //     showFullscreenButton: true,
  //     showVideoAnnotations: false,
  //     showControls: false,
  //   ),
  // );

  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(initialVideoId: "EdsC5J-FzJ8");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TheYoutubePlayerBuilder(
        player: TheYoutubePlayer(
          onReady: () {
            log("Video Player is Ready");
          },
          controller: _controller,
          aspectRatio: 16 / 9,
        ),
        builder: (context, player) {
          return player;
        },
      ),
    );
  }
}
