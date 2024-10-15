import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  Widget? controls;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
      setState(() {
        controls = GestureDetector(
          onTap: _togglePlayPause,
          child: Image.asset(
            'assets/icons/play.png', // Default to play
            height: 50,
          ),
        );
      });
    });

    _controller.addListener(() {
      setState(() {
        if (_controller.value.isPlaying) {
          controls = GestureDetector(
            onTap: _togglePlayPause,
            child: Image.asset(
              'assets/icons/pause.png', // Pause icon
              height: 50,
            ),
          );
        } else {
          controls = GestureDetector(
            onTap: _togglePlayPause,
            child: Image.asset(
              'assets/icons/play.png', // Play icon
              height: 50,
            ),
          );
        }
      });
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_controller), // Display the video
          Positioned.fill(
            child: Center(child: controls ?? Container()),
          ),
        ],
      ),
    );
  }
}
