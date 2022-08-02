import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';

class MySubscription extends StatefulWidget {
  @override
  _MySubscriptionState createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  String amount;

  @override
  void initState() {
    var future = Provider.of<ApiManager>(context, listen: false)
        .isSubscriptionApi(context);
    future.then((value) {
      setState(() {
        amount = value.data.packageAmount;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text(
          "MY SUBSCRIPTION",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future:
              Provider.of<ApiManager>(context, listen: false).subscribeApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var res = snapshot.data;
              if (res['is_subscribed'] == "YES")
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0XFF8BD2DF),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: EdgeInsets.only(
                                      left: 13, right: 13, top: 5, bottom: 5),
                                  child: Text(
                                    "STANDARD",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                              // SizedBox(height: 7,),
                              Text(
                                res['package_amount'],
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(height: 7,),
                              Text(
                                "Ends on ${res['subscription_end_date']}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 14,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 8.0,
                              dashColor: Colors.white,
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 120,
                        padding: EdgeInsets.only(left: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Feature",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 2, backgroundColor: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Progress Report Access",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "All Exercises",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Checkins Acess",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              else
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0XFF8BD2DF),
                                      borderRadius: BorderRadius.circular(4)),
                                  padding: EdgeInsets.only(
                                      left: 13, right: 13, top: 5, bottom: 5),
                                  child: Text(
                                    "STANDARD",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                              // SizedBox(height: 7,),
                              Text(
                                "4,999/-",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(height: 7,),
                              Text(
                                "For 3 months",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 14,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 8.0,
                              dashColor: Colors.white,
                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                              dashGapColor: Colors.transparent,
                              dashGapRadius: 0.0),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        height: 120,
                        padding: EdgeInsets.only(left: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Feature",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 2, backgroundColor: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Progress Report Access",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "All Exercises",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    "Checkins Acess",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
