import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/screen/ditetab.dart';
import 'package:twsuser/screen/measurement.dart';
import 'package:twsuser/screen/subworkout.dart';

class MyCheckin extends StatefulWidget {
  @override
  State<MyCheckin> createState() => _MyCheckinState();
}

class _MyCheckinState extends State<MyCheckin> {
  var statusCode, statusCheck = "", checkReferalStatus;

  void status() async {
    var statusCodes =
        await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
    checkReferalStatus = statusCodes;
    print(checkReferalStatus);
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var status = Provider.of<ApiManager>(context, listen: false)
          .isSubscriptionApi(context);
      status.then((value) async {
        setState(() {
          statusCode = value.errorCode.toString();
          print("errorCode" + value.errorCode.toString());
          if (value.errorCode.toString() == "1") {
            SharedPrefManager.savePrefString(
                AppConstant.TRAINERID, value.data.trainerId);
          }
        });
      });
    });
    status();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return statusCode == "1"
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black87,
                    bottom: TabBar(
                      labelColor: Colors.white,
                      tabs: [
                        Tab(
                          text: "Diet",
                        ),
                        Tab(
                          text: "Workout",
                        ),
                        Tab(
                          text: "Measurement",
                        ),
                      ],
                    ),
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      DietTab(),
                      SubWorkOut(),
                      Measurements(),
                    ],
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No Checkin Available"),
                    ],
                  ),
                ),
              )

        /*Container(height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text("No Gallery Available"),

            Container(
              margin: EdgeInsets.only(top: 35),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Text("Enter Referal Code",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                ),),
            ),

          ],
        ),),
    )*/
        ;
  }
}
