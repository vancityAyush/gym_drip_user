import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SubGallerydetail extends StatefulWidget {
  final String name, description, video;

  SubGallerydetail({this.name, this.description, this.video});

  @override
  State<SubGallerydetail> createState() => _SubGallerydetailState();
}

class _SubGallerydetailState extends State<SubGallerydetail> {
  FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
          "http://fitnessapp.frantic.in/" + widget.video),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          VisibilityDetector(
            key: ObjectKey(flickManager),
            onVisibilityChanged: (visibility) {
              if (visibility.visibleFraction == 0 && this.mounted) {
                flickManager.flickControlManager?.autoPause();
              } else if (visibility.visibleFraction == 1) {
                flickManager.flickControlManager?.autoResume();
              }
            },
            child: FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                controls: FlickLandscapeControls(),
                videoFit: BoxFit.fitWidth,
                willVideoPlayerControllerChange: false,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                      color: Color(0XFF3F3F3F),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
