import 'package:flutter/material.dart';
import 'package:twsuser/screen/subworkout.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  String dropdownValue = 'All Diet Taken';
  var selectedValue = "";
  List<String> spinnerItems = [
    'All Diet Taken',
    'All Diet Not Taken',
    'Add Other Food'
  ];

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
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  "assets/images/spalsh.jpg",
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
                          "Workout",
                          style: TextStyle(
                              fontSize:
                                  22 * MediaQuery.of(context).textScaleFactor,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
              ],
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
                        "27-02-2020",
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
                        "Thrusday",
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
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color(0XFFECECEC),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0XFFF7F7F7),
              padding: EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  // SizedBox(height: 10,),

                  ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 14,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 10),
                                child: Text(
                                  "Routine Workout",
                                  style: TextStyle(
                                      fontSize: 16 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                                itemCount: 4,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SubWorkOut()));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "3  x",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF515151)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Squad(Barbell)",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0XFF999999)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
