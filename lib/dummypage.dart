import 'package:flutter/material.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/webview.dart';

class DummyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              ElevatedButton(
                child: Text("Bmi Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("openbmichart/"+userId)));
                },
              ),

              ElevatedButton(
                child: Text("Body Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("openbodychart/"+userId)));
                },
              ),

              ElevatedButton(
                child: Text("Cal Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("opencalchart/"+userId)));
                },
              ),

              ElevatedButton(
                child: Text("Run Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("openrunchart/"+userId)));
                },
              ),

              ElevatedButton(
                child: Text("Skin Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("openSkinChart/"+userId)));
                },
              ),

              ElevatedButton(
                child: Text("Rm Chart", style: TextStyle(fontSize: 20),),
                onPressed: ()async{
                  var userId = await SharedPrefManager.getPrefrenceString(AppConstant.USERIDGRAPH);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample("openrmchart/"+userId)));
                },
              ),
            ],
       )),
    );
  }
}