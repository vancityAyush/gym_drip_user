// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/addfood.dart';

class DietTab extends StatefulWidget {
  @override
  _DietTabState createState() => _DietTabState();
}

class _DietTabState extends State<DietTab> {
  String dropdownValue = 'All Diet Taken';

  List<String> spinnerItems = [
    'All Diet Taken',
    'All Diet Not Taken',
    'Add Other Food'
  ];

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
                          "Diet",
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
            FutureBuilder(
              future: Provider.of<ApiManager>(context)
                  .fetchDietByDatesApi(formatDate),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      /*Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Carbohydrate",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Proxima Nova"
                                    ),),


                                  Text("Protein",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Proxima Nova"
                                    ),),


                                  Text("Fat",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Proxima Nova"
                                    ),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: <Widget>[

                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 21),
                                        child: Text('10/12',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Proxima Nova"
                                          ),),
                                      ),
                                    ),
                                  ),


                                  Expanded(
                                    flex:1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text("12/15",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Proxima Nova"
                                          ),),
                                      ),
                                    ),
                                  ),


                                  Expanded(
                                    flex:1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("8/9",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Proxima Nova"
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),*/

                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFFF7F7F7),
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: <Widget>[
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data['data'].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14.0, right: 10, top: 14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data['data'][index]
                                                  ['meal']['name'],
                                              style: TextStyle(
                                                  fontSize: 16 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  color: Colors.redAccent,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          itemCount: snapshot
                                              .data['data'][index]['food']
                                              .length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  color: snapshot.data['data']
                                                                      [index]
                                                                  ['food'][i]
                                                              ['isTaken'] ==
                                                          false
                                                      ? snapshot.data['data']
                                                                          [index]
                                                                      [
                                                                      'food'][i]
                                                                  [
                                                                  'created_by'] ==
                                                              "USER"
                                                          ? Colors.redAccent
                                                          : Colors.white
                                                      : Color(0XFFCDE9FF),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30),
                                                    child: ListTile(
                                                      onTap: () {
                                                        if (snapshot.data['data']
                                                                        [index]
                                                                    ['food'][i][
                                                                'created_by'] ==
                                                            "USER") {
                                                        } else {
                                                          setState(() {
                                                            Provider.of<ApiManager>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .mealTakenApi(
                                                                    snapshot.data['data'][index]
                                                                            ['meal']
                                                                        ['id'],
                                                                    snapshot.data['data']
                                                                            [
                                                                            index]['food']
                                                                        [
                                                                        i]['id']);
                                                          });
                                                        }
                                                      },
                                                      leading: Icon(
                                                        snapshot.data['data'][
                                                                            index]
                                                                        [
                                                                        'food'][i]
                                                                    [
                                                                    'isTaken'] ==
                                                                false
                                                            ? Icons.clear
                                                            : Icons.check,
                                                        color: snapshot.data['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'food'][i]
                                                                    [
                                                                    'isTaken'] ==
                                                                true
                                                            ? Colors.blue
                                                            : Color(0XFFCDE9FF),
                                                      ),
                                                      title: Text(
                                                        snapshot.data['data']
                                                                [index]['food']
                                                            [i]['name'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Color(
                                                                0XFF262626),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                      subtitle: Text(
                                                        "C - " +
                                                            snapshot.data['data']
                                                                        [index]
                                                                    ['food'][i]
                                                                ['carbs'] +
                                                            "  , P - " +
                                                            snapshot.data['data']
                                                                        [index]
                                                                    ['food'][i]
                                                                ['protein'] +
                                                            "  , F - " +
                                                            snapshot.data['data']
                                                                        [index]
                                                                    ['food'][i]
                                                                ['fats'],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Color(
                                                                0XFF262626),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                      trailing: Text(
                                                        snapshot.data['data']
                                                                        [index]
                                                                    ['food'][i]
                                                                ['carbs'] +
                                                            " Kcal",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Color(
                                                                0XFF262626),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  bottom: 0,
                                                  top: 0,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.more_vert,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) => AddFood(
                                                        id: snapshot
                                                            .data['data'][index]
                                                                ['meal']['id']
                                                            .toString(),
                                                      )));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "+ Add Food",
                                                style: TextStyle(
                                                    fontSize: 15 *
                                                        MediaQuery.of(context)
                                                            .textScaleFactor,
                                                    color: Colors.redAccent,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Carbohydrate",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.orange,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Proxima Nova"),
                                                  ),
                                                  Text(
                                                    "Protein",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Proxima Nova"),
                                                  ),
                                                  Text(
                                                    "Fat",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            "Proxima Nova"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 21),
                                                        child: Text(
                                                          snapshot.data['data']
                                                                      [index][
                                                                      'total_taken_carb']
                                                                  .toString() +
                                                              "/" +
                                                              snapshot
                                                                  .data['data']
                                                                      [index][
                                                                      'total_carbs']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.orange,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Proxima Nova"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Text(
                                                          snapshot.data['data']
                                                                      [index][
                                                                      'total_taken_protein']
                                                                  .toString() +
                                                              "/" +
                                                              snapshot
                                                                  .data['data']
                                                                      [index][
                                                                      'total_proteins']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Proxima Nova"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        snapshot.data['data']
                                                                    [index][
                                                                    'total_taken_fat']
                                                                .toString() +
                                                            "/" +
                                                            snapshot
                                                                .data['data']
                                                                    [index][
                                                                    'total_fats']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Proxima Nova"),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Text("");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
