import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/subgallerydetails.dart';
import 'package:twsuser/video/VideoApp.dart';

class SubGalleries extends StatefulWidget {
  String id, description, name, image;

  SubGalleries({this.id, this.description, this.name, this.image});

  @override
  _SubGalleriesState createState() => _SubGalleriesState();
}

class _SubGalleriesState extends State<SubGalleries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: Visibility(
            visible: false,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  "http://fitnessapp.frantic.in/" + widget.image,
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 15,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.accessible_forward_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          height: 40,
                          width: 2,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize:
                                  22 * MediaQuery.of(context).textScaleFactor,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Overview",
                      style: TextStyle(
                          fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                          color: Color(0XFF4E4E4E),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFFBDBDBD),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 3,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.description,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Exercise",
                      style: TextStyle(
                          fontSize: 19 * MediaQuery.of(context).textScaleFactor,
                          color: Color(0XFF4E4E4E),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFFBDBDBD),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 90,
                        height: 3,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  FutureBuilder(
                    future: Provider.of<ApiManager>(context)
                        .fetchExerciseByWorkoutId(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (snapshot.data['data'][index]
                                          ['you_tube_link'] ==
                                      "") {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubGallerydetail(
                                                    name: snapshot.data['data']
                                                        [index]['name'],
                                                    description: snapshot
                                                            .data['data'][index]
                                                        ['description'],
                                                    video: snapshot.data['data']
                                                        [index]['video'])));
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubCategoryDetail(video:data[index].video,description:data[index].description,name:data[index].name)));
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => VideoApp(
                                                youtubelink:
                                                    snapshot.data['data'][index]
                                                        ['you_tube_link'],
                                                description:
                                                    snapshot.data['data'][index]
                                                        ['description'],
                                                name: snapshot.data['data']
                                                    [index]['name'])));
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              "assets/images/spalsh.jpg",
                                              width: 140,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data['data'][index]
                                                      ['name'],
                                                  style: TextStyle(
                                                      fontSize: 19 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Visibility(
                                            visible: false,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 1,
                                              color: Color(0XFFBDBDBD),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 35),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 1,
                                            color: Color(0XFFDBDBDB),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Text("");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
