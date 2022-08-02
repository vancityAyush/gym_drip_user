// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apiResponse/ResponseReviewProfile.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/chat/newChatScreen.dart';
import 'package:twsuser/screen/trainerpreview.dart';

class MyTrainer extends StatelessWidget {
  Data data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          "MY TRAINERS",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => ChatScreenNew(name: data.name)));
            },
            child: Icon(
              Icons.message,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ApiManager>(context).fetchTrainerProfileApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ResponseReviewProfile responseReviewProfile = snapshot.data;
            data = responseReviewProfile.data;
            return data.privacyStatus == null
                ? Text("No Profile Available")
                : data.privacyStatus == "PUBLIC"
                    ? Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0XFFDBDBDB), width: 1),
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0XFFDBDBDB),
                              backgroundImage: data.image == null
                                  ? AssetImage("assets/images/user.png")
                                  : NetworkImage(
                                      "http://fitnessapp.frantic.in/" +
                                          data.image),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              data.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.bio == null ? "" : data.bio,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    height: 1.2,
                                    color: Color(0XFF363636),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => TrainerPreview()));
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 35),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Text(
                                    "VIEW PROFILE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0XFFDBDBDB), width: 1),
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0XFFDBDBDB),
                              backgroundImage: data.image == null
                                  ? AssetImage("assets/images/user.png")
                                  : NetworkImage(
                                      "http://fitnessapp.frantic.in/" +
                                          data.image),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              data.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data.bio == null ? "" : data.bio,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    height: 1.2,
                                    color: Color(0XFF363636),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => TrainerPreview()));
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 35),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Text(
                                    "VIEW PROFILE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
          } else {
            return Center(child: Text("No trainer available"));
          }
        },
      ),
    );
  }
}
