import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

@RoutePage()
class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});
  @override
  State<VideoScreen> createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late final player = Player();

  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();

    final randomExerciseNumber = Random().nextInt(94);

    player.open(
      Media(
        'https://storage.googleapis.com/utfpr/pai-move-on-app/codificados/HLS/$randomExerciseNumber/master.m3u8',
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).width * 9.0 / 16.0,
          child: Video(controller: controller),
        ),
      ),
    );
  }
}
