import 'dart:io';
import 'package:file/local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';

class NewMessagesChat extends StatefulWidget {

  @override
  _NewMessagesChatState createState() => _NewMessagesChatState();
}

class _NewMessagesChatState extends State<NewMessagesChat> {

  LocalFileSystem localFileSystem = LocalFileSystem();
  File filename;
  File newFile;
  PlatformFile file;
  var _enteredMessage = '';
  final controller = new TextEditingController();

  void _sendMessage() async {
    filename = null;
    FocusScope.of(context).unfocus();
    // setState(() {
      Provider.of<ApiManager>(context,listen: false).sendMessageApi( _enteredMessage);
    // });
    controller.clear();}


  void onFileOpen() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png'],);
    if(result != null) {
      file = result.files.first;
      filename = File(file.path);
      Provider.of<ApiManager>(context,listen: false).newSendMessageApi( _enteredMessage,filename);
      setState(() {
        newFile = filename;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1),
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[

          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(33),
              ),
              elevation: 4,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left :10.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Type a message...',
                      border: InputBorder.none),
                      controller: controller,
                      onChanged: (value){
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: Center(
                      child: IconButton(
                        onPressed: (){onFileOpen();},
                        icon: Icon(
                          Icons.attach_file_rounded,
                          color: Colors.grey,
                          size: 26,),
                      ),
                     ),
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 23,
            child: IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(
                    Icons.send,
                  color: Colors.white,
                ),
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage
            ),
          ),

        ],
      ),
    );
  }

}