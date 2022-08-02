// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';

import '../apiService/AppConstant.dart';
import '../apiService/sharedprefrence.dart';

class Measurements extends StatefulWidget {
  @override
  State<Measurements> createState() => _MeasurementsState();
}

class _MeasurementsState extends State<Measurements> {
  TextEditingController weightController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController chestController = TextEditingController();
  TextEditingController leftBicepsController = TextEditingController();
  TextEditingController rightBicepsController = TextEditingController();
  TextEditingController upperAbsController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController lowerAbsController = TextEditingController();
  TextEditingController hipsController = TextEditingController();
  TextEditingController leftThighController = TextEditingController();
  TextEditingController rightThighController = TextEditingController();
  TextEditingController chestTricepsController = TextEditingController();
  TextEditingController absController = TextEditingController();
  TextEditingController thighController = TextEditingController();
  bool _isLoad = false;

  void _trySubmit() async {
    if (weightController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter weight");
    } else if (neckController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter neck");
    } else if (shoulderController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter shoulders");
    } else if (chestController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter chest");
    } else if (leftBicepsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter left biceps");
    } else if (rightBicepsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter right biceps");
    } else if (upperAbsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter upper abs");
    } else if (waistController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter waist");
    } else if (lowerAbsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter lower abs");
    } else if (hipsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter hips");
    } else if (leftThighController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter left thigh");
    } else if (rightThighController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter right thigh");
    } else if (chestTricepsController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter chest/triceps");
    } else if (absController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter abs");
    } else if (thighController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter left thigh");
    } else {
      setState(() {
        _isLoad = true;
      });
      var res = await Provider.of<ApiManager>(context, listen: false)
          .storeMeasurement(
              weight: weightController.text,
              neck: neckController.text,
              shoulders: shoulderController.text,
              chest: chestController.text,
              left_biceps: leftBicepsController.text,
              right_biceps: rightBicepsController.text,
              upper_abs: upperAbsController.text,
              waist: waistController.text,
              lower_abs: lowerAbsController.text,
              hips: hipsController.text,
              left_thigh: leftThighController.text,
              right_thigh: rightThighController.text,
              chest_triceps: chestTricepsController.text,
              abs: absController.text,
              thigh: thighController.text);
      if (res['error_code'] == 1) {
        Fluttertoast.showToast(msg: "Measurement added successfully");
      } else {
        Fluttertoast.showToast(msg: res['response_string']);
      }
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    neckController.dispose();
    shoulderController.dispose();
    shoulderController.dispose();
    chestController.dispose();
    leftBicepsController.dispose();
    rightBicepsController.dispose();
    upperAbsController.dispose();
    waistController.dispose();
    lowerAbsController.dispose();
    hipsController.dispose();
    leftThighController.dispose();
    rightThighController.dispose();
    chestTricepsController.dispose();
    absController.dispose();
    thighController.dispose();
    super.dispose();
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
                          "Measurement",
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Body Measurement",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
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
                        width: 150,
                        height: 3,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Neck",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Kg",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: neckController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Shoulders",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Chest",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: shoulderController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: chestController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Left Biceps",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Right Biceps",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: leftBicepsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: rightBicepsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Upper Abs",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Waist",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: upperAbsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: waistController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Lower Abs",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hips",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: lowerAbsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: hipsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Left Thigh",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Right Thigh",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: leftThighController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: rightThighController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skin Fold Measurement",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
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
                        width: 180,
                        height: 3,
                        color: Colors.redAccent,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FutureBuilder(
                            future: SharedPrefManager.getPrefrenceString(
                                AppConstant.GENDER),
                            builder: (contex, snapshot) => Text(
                              snapshot.hasData
                                  ? snapshot.data == 'MALE'
                                      ? 'Chest'
                                      : 'Triceps'
                                  : "Chest/triceps",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFFAFAFAF)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Abs",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: chestTricepsController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          // decoration: const InputDecoration(
                          //   hintText: 'Bio',
                          //   labelText: 'Bio',
                          //
                          // ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: absController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 12),
                            hintText: "Inches/Centimeters",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Thigh",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFAFAFAF)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Visibility(
                        visible: false,
                        child: Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Abs",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFFAFAFAF)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: thighController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Inches/Centimeters",
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: Visibility(
                          visible: false,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.always,
                            style: TextStyle(color: Color(0XFF262626)),
                            decoration: InputDecoration(
                              fillColor: Color(0XFFF2F2F2),
                              filled: true,
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: "Inches/Centimeters",
                            ),
                            onSaved: (String value) {},
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (_isLoad)
              CircularProgressIndicator()
            else
              GestureDetector(
                onTap: _trySubmit,
                child: Container(
                  margin:
                      EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                  // width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
