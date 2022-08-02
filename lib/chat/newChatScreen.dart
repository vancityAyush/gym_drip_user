import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apiResponse/ResponseFetchChatMessage.dart';
import 'package:twsuser/apiService/apiResponse/ResponseFetchChatMessage.dart';
import 'package:twsuser/apiService/apiResponse/ResponseFetchChatMessage.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';

import 'newMessageBubble.dart';
import 'newMessages.dart';

class ChatScreenNew extends StatefulWidget {

  final String name;
  ChatScreenNew({this.name});

  @override
  _ChatScreenNewState createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {

  StreamController<ResponseFetchChatMessage> _controller = StreamController<ResponseFetchChatMessage>.broadcast();

  var id;
  final controller = new TextEditingController();
  Timer timer;
  Future future;

  void userId() async{
    id = await SharedPrefManager.getPrefrenceString(AppConstant.USERID);
    print("idsssss"+id);
  }

  @override
  void initState() {
    super.initState();
    userId();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(Duration(seconds: 1), (_) => loadDetails());
    });}

  loadDetails() async {
    future = Provider.of<ApiManager>(context,listen: false).fetchIndividualChat();
    future.then((response) async{
        _controller.add(response);
      return response;
    });}

  @override
  void dispose() {
    _controller.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),
        elevation: 0.0,
        backgroundColor: Color(0xff00AFF0),),
      body: Container(child: Column(children: <Widget>[
        Expanded(
          child: FutureBuilder(
            future: Provider.of<ApiManager>(context).fetchIndividualChat(),
            builder:(ctx, futureSnapShots) {
              if (futureSnapShots.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }else{
                if(futureSnapShots.hasData){
                  return StreamBuilder(
                    stream: _controller.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<ResponseFetchChatMessage> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text('None'),);
                          break;
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                          break;
                        case ConnectionState.active:
                          List<DataChat> data = snapshot.data.data;
                          return ListView.builder(
                              reverse: true,
                              itemCount: data.length,
                              itemBuilder: (ctx, index) => NewMessageBubble(data[index].msg,
                                      data[index].msgBy, id ,data[index].msgType));
                          break;
                        case ConnectionState.done:
                          print('Done data is here ${snapshot.data}');
                          if (snapshot.hasData) {
                            return Center(
                              child: Text(
                                snapshot.data == null ? Text(
                                    "No messages are available") : snapshot.data,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Has Error');
                          } else {
                            return Text('Error');
                          }
                          break;}
                          return Text('Non in Switch');
                      },
                  );
                }
              else{
                  return Text("s");
                  return Center(child: Text("No messages are there",
                    style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontWeight: FontWeight.w600,
                        fontSize: 20*MediaQuery.of(context).textScaleFactor
                    ),),
                  );
                }}},),),
        NewMessagesChat(),
      ],
      ),
      ),
    );
  }
}