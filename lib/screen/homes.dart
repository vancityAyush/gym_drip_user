import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/screen/subgalleries.dart';

class Homes extends StatefulWidget {
  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  bool isLoad = false;
  TextEditingController controllerRefeCode = TextEditingController();
  var statusCode, statusCheck = "", checkReferalStatus = "";

  void statuss() async {
    var statusCodes =
        await SharedPrefManager.getPrefrenceString(AppConstant.STATUS);
    checkReferalStatus = statusCodes;
    print("status" + statusCodes.toString());
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      statuss();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 5.6;
    double cardHeight = MediaQuery.of(context).size.height * 3.0;
    List<dynamic> data = [];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text(
            "Galleries",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                    context: context, delegate: CustomSearchDelegate(data));
              },
            ),
          ],
          leading: Visibility(
              visible: false,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (statusCode.toString() == "0")
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("No Gallery Available"),
                        InkWell(
                          onTap: () {
                            return showDialog(
                                context: context,
                                builder: (ctx) => StatefulBuilder(
                                      builder: (context, setState) {
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0)),
                                            child: Stack(
                                              alignment: Alignment.topCenter,
                                              children: [
                                                Container(
                                                  height: 300,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 20, 10, 10),
                                                    child: Column(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            "Enter Trainer's Referral Code",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .redAccent),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              controllerRefeCode,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .always,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0XFF262626)),
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Color(
                                                                0XFFF2F2F2),
                                                            filled: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Eg: TWS0000011PS",
                                                          ),
                                                          onSaved:
                                                              (String value) {},
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          "Trainer's referal code is the code given by your trainer to access the premium account to team with someone",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0XFF8F9190),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        if (isLoad)
                                                          CircularProgressIndicator()
                                                        else
                                                          GestureDetector(
                                                            onTap: () async {
                                                              setState(() {
                                                                isLoad = true;
                                                              });
                                                              await Provider.of<
                                                                          ApiManager>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .useRefCodeApi(
                                                                      controllerRefeCode
                                                                          .text,
                                                                      context);
                                                              setState(() {
                                                                isLoad = false;
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0XFF2CB3BF),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25)),
                                                              child: Center(
                                                                child: Text(
                                                                  "Enter trainer's Referral Code",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      },
                                    ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 35),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(7)),
                            child: Text(
                              "Enter Referal Code",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (checkReferalStatus == "PUBLIC")
                FutureBuilder(
                  future: Provider.of<ApiManager>(context).fetchWorkoutApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: cardWidth / cardHeight,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 7),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => SubGalleries(
                                                id: snapshot.data['data'][index]
                                                    ['id'],
                                                description:
                                                    snapshot.data['data'][index]
                                                        ['description'],
                                                name: snapshot.data['data']
                                                    [index]['name'],
                                                image: snapshot.data['data']
                                                    [index]['image'])));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "http://fitnessapp.frantic.in/" +
                                                  snapshot.data['data'][index]
                                                      ['image'],
                                              fit: BoxFit.cover,
                                            )),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        left: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                          child: Column(
                                            children: [
                                              Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 2,
                                                          right: 10,
                                                          bottom: 2),
                                                  child: Text(
                                                    snapshot.data['data'][index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }));
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            "No workout added yet",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                )
              else
                FutureBuilder(
                  future: Provider.of<ApiManager>(context).fetchWorkoutApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      data = snapshot.data['data'];
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: cardWidth / cardHeight,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 7),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => SubGalleries(
                                                id: snapshot.data['data'][index]
                                                    ['id'],
                                                description:
                                                    snapshot.data['data'][index]
                                                        ['description'],
                                                name: snapshot.data['data']
                                                    [index]['name'],
                                                image: snapshot.data['data']
                                                    [index]['image'])));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "http://fitnessapp.frantic.in/" +
                                                  snapshot.data['data'][index]
                                                      ['image'],
                                              fit: BoxFit.cover,
                                            )),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 25,
                                        left: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent),
                                          child: Column(
                                            children: [
                                              Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 2,
                                                          right: 10,
                                                          bottom: 2),
                                                  child: Text(
                                                    snapshot.data['data'][index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }));
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            "No workout added yet",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      );
                    }
                  },
                )
            ],
          ),
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<dynamic> data;
  CustomSearchDelegate(this.data);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> matchQuery = [];
    if (query.isNotEmpty) {
      for (var item in data) {
        if (item['name'].toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    return ListView.builder(
      itemCount: matchQuery == null ? 0 : matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]['name']),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubGalleries(
                    id: matchQuery[index]['id'],
                    description: matchQuery[index]['description'],
                    name: matchQuery[index]['name'],
                    image: matchQuery[index]['image']),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> matchQuery = [];
    if (query.isNotEmpty) {
      for (var item in data) {
        if (item['name'].toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(item);
        }
      }
    }
    return ListView.builder(
      itemCount: matchQuery == null ? 0 : matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(matchQuery[index]['name']),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubGalleries(
                    id: matchQuery[index]['id'],
                    description: matchQuery[index]['description'],
                    name: matchQuery[index]['name'],
                    image: matchQuery[index]['image']),
              ),
            );
          },
        );
      },
    );
  }
}
