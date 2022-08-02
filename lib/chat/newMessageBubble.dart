import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

enum PlayerState { stopped, playing, paused }

class NewMessageBubble extends StatefulWidget {

  NewMessageBubble(
      this.message,
      this.isMe,
      this.id,
      this.msgType,
      {this.key});

  final Key key;
  final String message;
  final String isMe;
  final String id;
  final String msgType;

  @override
  _NewMessageBubbleState createState() => _NewMessageBubbleState();
}

class _NewMessageBubbleState extends State<NewMessageBubble> {

  Duration duration;
  Duration position;
  String localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          Row(
            mainAxisAlignment: widget.isMe == widget.id ? MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
               Container(
                decoration: BoxDecoration(
                  color: widget.isMe ==widget.id ? Colors.grey[300] : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    // bottomLeft: !isMe == ? Radius.circular(0) : Radius.circular(12),
                    bottomRight: widget.isMe == widget.id ? Radius.circular(0) : Radius.circular(25),
                  ),
                ),
                width: 180,
                padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0
                ),
                margin: EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 8),
                child:Column(
                  crossAxisAlignment: widget.isMe ==widget.id ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
                  children: <Widget>[
                    widget.msgType == "image" ? GestureDetector(
                      onTap: (){
                        },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network("http://fitnessapp.frantic.in/"+widget.message,
                            fit: BoxFit.contain,)),
                    ):Text(widget.message,style: TextStyle(color: widget.isMe == widget.id ? Colors.black : Theme.of(context).accentTextTheme.headline1.color))
                    // msgType =="image"?Text(message,style: TextStyle(color: isMe == id ? Colors.black : Theme.of(context).accentTextTheme.headline1.color),):,
                  ],
                ),
              ),
            ],
          )
        ]
    );
  }

}