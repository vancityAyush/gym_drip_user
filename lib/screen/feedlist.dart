import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apiResponse/ResponseBlogs.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/screen/feedlistdetail.dart';

class FeedList extends StatefulWidget {
  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  var statusCode, subscriptionStatus;

  void status() async {
    var statusCodes =
        await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
    var subscription = await SharedPrefManager.getPrefrenceString(
            AppConstant.TRAINERSUBSCRIPTION) !=
        null;
    print("subscription" + subscription.toString());
    statusCode = statusCodes;
    subscriptionStatus = subscription;
    print(statusCode);
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      status();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          "Feeds",
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
      body: FutureBuilder(
        future: Provider.of<ApiManager>(context).blogApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ResponseBlogs responseBlogs = snapshot.data;
            List<Data> data = responseBlogs.data;
            return SingleChildScrollView(
                child: Column(
              children: [
                if (statusCode == "PRIVATE")
                  if (subscriptionStatus == false)
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: Text("No Blogs available")))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FeedListDetail(
                                        image: data[index].image,
                                        name: data[index].title,
                                        description: data[index].description)));
                              },
                              child: Card(
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: data[index].video == null
                                              ? Image.network(
                                                  "http://fitnessapp.frantic.in/" +
                                                      data[index].image,
                                                  height: 185,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                )
                                              : Image.asset(
                                                  "assets/images/spalsh.jpg",
                                                  height: 185,
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          data[index].title,
                                          style: TextStyle(
                                              fontSize: 19 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          data[index].description,
                                          style: TextStyle(
                                              color: Color(0XFFC9C9C9),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    )
                else if (subscriptionStatus == false)
                  Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: Text("No Blogs available")))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FeedListDetail(
                                      image: data[index].image,
                                      name: data[index].title,
                                      description: data[index].description)));
                            },
                            child: Card(
                              elevation: 15,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: data[index].video == null
                                            ? Image.network(
                                                "http://fitnessapp.frantic.in/" +
                                                    data[index].image,
                                                height: 185,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )
                                            : Image.asset(
                                                "assets/images/spalsh.jpg",
                                                height: 185,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        data[index].title,
                                        style: TextStyle(
                                            fontSize: 19 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        data[index].description,
                                        style: TextStyle(
                                            color: Color(0XFFC9C9C9),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  )
              ],
            ));
          } else {
            return Center(child: Text("No Blogs available"));
          }
        },
      ),
    );
  }
}
