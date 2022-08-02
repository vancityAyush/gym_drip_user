import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/subcategorydetails.dart';
import 'package:twsuser/video/VideoApp.dart';

class SubWorkOut extends StatefulWidget {
  @override
  State<SubWorkOut> createState() => _SubWorkOutState();
}

class _SubWorkOutState extends State<SubWorkOut> {
  var selectedValue = "", formatDate;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formatDate = selectedDate.year.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.day.toString();
      });
  }

  @override
  void initState() {
    formatDate = selectedDate.year.toString() +
        "/" +
        selectedDate.month.toString() +
        "/" +
        selectedDate.day.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Image.asset(
                "assets/images/spalsh.jpg",
                height: 130,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        formatDate.toString(),
                        style: TextStyle(
                            fontSize:
                                17 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF373737),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        height: 27,
                        width: 2,
                        color: Color(0XFF373737),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize:
                                18 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF373737),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 6),
              padding: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent, width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: FutureBuilder(
                  future: Provider.of<ApiManager>(context)
                      .fetchWorkoutByDatesApi(formatDate),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "TEMPLATE 1",
                              style: TextStyle(
                                  fontSize: 18 *
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent),
                            ),
                            subtitle: Text(
                              "${selectedDate.day} ${selectedDate.month} ${selectedDate.year}",
                              style: TextStyle(
                                  fontSize: 13 *
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF262626)),
                            ),
                            trailing: Container(
                              width: 53,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/downarrow.png",
                                    width: 15,
                                    height: 15,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.more_vert)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 19,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.expand,
                                      size: 19,
                                      color: Colors.redAccent,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "5060 KG",
                                      style: TextStyle(
                                          fontSize: 12 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF262626)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data['data'].length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    setState(() {
                                      if (snapshot.data['data'][index]
                                                  ['exercise']['is_done']
                                              .toString() ==
                                          "NO") {
                                        Provider.of<ApiManager>(context,
                                                listen: false)
                                            .workOutTakenApi(
                                                snapshot.data['data'][index]
                                                        ['exercise']['id']
                                                    .toString(),
                                                "YES");
                                      } else {
                                        Provider.of<ApiManager>(context,
                                                listen: false)
                                            .workOutTakenApi(
                                                snapshot.data['data'][index]
                                                        ['exercise']['id']
                                                    .toString(),
                                                "NO");
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 15),
                                    color: snapshot.data['data'][index]
                                                    ['exercise']['is_done']
                                                .toString() ==
                                            "YES"
                                        ? Colors.black12
                                        : Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Exercise Name:  " +
                                                        snapshot.data['data']
                                                                    [index]
                                                                ['exercise']
                                                            ['exercise_name'],
                                                    style: TextStyle(
                                                        fontSize: 15 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .textScaleFactor,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.redAccent),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (snapshot.data['data']
                                                              [index]['video']
                                                          ['you_tube_link'] ==
                                                      "") {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => SubCategoryDetail(
                                                            video: snapshot.data['data']
                                                                        [index]
                                                                    ['video']
                                                                ['video'],
                                                            description: snapshot
                                                                        .data['data']
                                                                    [index]['video']
                                                                ['description'],
                                                            name: snapshot.data['data']
                                                                        [index]
                                                                    ['video']
                                                                ['name'])));
                                                  } else {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => VideoApp(
                                                            youtubelink: snapshot.data['data']
                                                                        [index]
                                                                    ['video'][
                                                                'you_tube_link'],
                                                            description: snapshot
                                                                        .data['data']
                                                                    [index]['video']
                                                                ['description'],
                                                            name: snapshot.data['data']
                                                                    [index]['video']
                                                                ['name'])));
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.black,
                                                  child: Icon(
                                                    Icons.video_call_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (snapshot.data['data'][index]
                                                ['sets'] ==
                                            null)
                                          Text("")
                                        else
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: snapshot
                                                  .data['data'][index]['sets']
                                                  .length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  children: <Widget>[
                                                    if (snapshot.data['data'][
                                                                            index]
                                                                        ['sets']
                                                                    [i]['sets']
                                                                ['breath'] !=
                                                            "0.00" &&
                                                        snapshot.data['data']
                                                                        [index]
                                                                    ['sets'][i][
                                                                'sets']['reps'] !=
                                                            "0.00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Breath (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .redAccent,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          '${snapshot.data['data'][index]['sets'][i]['sets']['breath']}',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "Reps ${snapshot.data['data'][index]['sets'][i]['sets']['reps']}",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                    else if (snapshot.data['data']
                                                                            [index]
                                                                        ['sets']
                                                                    [i]['sets']
                                                                ['time'] !=
                                                            "00:00:00" &&
                                                        snapshot.data['data']
                                                                            [index]
                                                                        ['sets']
                                                                    [i]['sets']
                                                                ['level'] !=
                                                            "0.00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Time (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFF262626),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          '${snapshot.data['data'][index]['sets'][i]['sets']['time']}',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "Level ${snapshot.data['data'][index]['sets'][i]['sets']['level']}",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                    else if (snapshot
                                                            .data['data'][index]
                                                                ['sets'][i]
                                                                ['sets']['kg']
                                                            .toString() !=
                                                        "0.00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Weight",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFF262626),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          ' (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "${snapshot.data['data'][index]['sets'][i]['sets']['kg']} KG",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                    else if (snapshot.data[
                                                                    'data']
                                                                [index]['sets']
                                                            [i]['sets']['km'] !=
                                                        "0.00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Running",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFF262626),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          ' (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "${snapshot.data['data'][index]['sets'][i]['sets']['km']} km",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                    else if (snapshot.data[
                                                                        'data']
                                                                    [index]
                                                                ['sets'][i]
                                                            ['sets']['time'] !=
                                                        "00:00:00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Time",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFF262626),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          " (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})",
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "${snapshot.data['data'][index]['sets'][i]['sets']['time']}",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                    else if (snapshot.data[
                                                                        'data']
                                                                    [index]
                                                                ['sets'][i][
                                                            'sets']['breath'] !=
                                                        "0.00")
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Breath",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0XFF262626),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  TextSpan(
                                                                      text:
                                                                          ' (${snapshot.data['data'][index]['sets'][i]['sets']['set_type']})',
                                                                      style: TextStyle(
                                                                          color: Color(
                                                                              0XFF262626),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                                                      //   // Double tapped.
                                                                      // }
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                                "${snapshot.data['data'][index]['sets'][i]['sets']['breath']}",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0XFF262626),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                          ],
                                                        ),
                                                      )
                                                  ],
                                                );
                                              })
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              }),
                        ],
                      );
                    } else {
                      return Text("");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/*                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'W',
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      */ /*recognizer: TapGestureRecognizer()..onTap = () {
                                // Single tapped.
                              },*/ /*
                                    ),
                                    TextSpan(
                                        text: ' 12 KGX5',
                                        style: TextStyle(color: Color(0XFF262626),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)
                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                      //   // Double tapped.
                                      // }
                                    ),
                                  ],
                                ),
                              ),

                              Text("60 KG",
                                  style: TextStyle(color: Color(0XFF262626),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'W',
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      */ /*recognizer: TapGestureRecognizer()..onTap = () {
                                // Single tapped.
                              },*/ /*
                                    ),
                                    TextSpan(
                                        text: ' 12 KGX5',
                                        style: TextStyle(color: Color(0XFF262626),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)
                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                      //   // Double tapped.
                                      // }
                                    ),
                                  ],
                                ),
                              ),

                              Text("60 KG",
                                  style: TextStyle(color: Color(0XFF262626),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,top: 40),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("CHEST FLY",style: TextStyle(
                                fontSize: 15*MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFF262626)
                            ),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'W',
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      */ /*recognizer: TapGestureRecognizer()..onTap = () {
                                // Single tapped.
                              },*/ /*
                                    ),
                                    TextSpan(
                                        text: ' 12 KGX5',
                                        style: TextStyle(color: Color(0XFF262626),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)
                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                      //   // Double tapped.
                                      // }
                                    ),
                                  ],
                                ),
                              ),

                              Text("60 KG",
                                  style: TextStyle(color: Color(0XFF262626),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'W',
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      */ /*recognizer: TapGestureRecognizer()..onTap = () {
                                // Single tapped.
                              },*/ /*
                                    ),
                                    TextSpan(
                                        text: ' 12 KGX5',
                                        style: TextStyle(color: Color(0XFF262626),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)
                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                      //   // Double tapped.
                                      // }
                                    ),
                                  ],
                                ),
                              ),

                              Text("60 KG",
                                  style: TextStyle(color: Color(0XFF262626),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'W',
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      */ /*recognizer: TapGestureRecognizer()..onTap = () {
                                // Single tapped.
                              },*/ /*
                                    ),
                                    TextSpan(
                                        text: ' 12 KGX5',
                                        style: TextStyle(color: Color(0XFF262626),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)
                                      // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
                                      //   // Double tapped.
                                      // }
                                    ),
                                  ],
                                ),
                              ),

                              Text("60 KG",
                                  style: TextStyle(color: Color(0XFF262626),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))

                            ],
                          ),
                        ),*/
