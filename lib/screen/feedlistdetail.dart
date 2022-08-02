// @dart=2.9
import 'package:flutter/material.dart';

class FeedListDetail extends StatelessWidget {
  final String image, name, description;
  FeedListDetail({this.image, this.name, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(
          name,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "http://fitnessapp.frantic.in/" + image,
                height: 185,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
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
                  width: 95,
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
                description,
                style: TextStyle(
                    color: Color(0XFFA3A3A3),
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
