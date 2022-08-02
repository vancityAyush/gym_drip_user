import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoApp extends StatelessWidget {
  String youtubelink, description, name;

  VideoApp({this.youtubelink, this.description, this.name});

  @override
  Widget build(BuildContext context) {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(youtubelink);
    print(videoId);

    YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            onReady: () {
              print("player ready..");
            },
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
