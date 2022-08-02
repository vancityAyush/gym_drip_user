import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';

class RegisterSetUpProfile extends StatefulWidget {
  @override
  _RegisterSetUpProfileState createState() => _RegisterSetUpProfileState();
}

class _RegisterSetUpProfileState extends State<RegisterSetUpProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController email = TextEditingController();

  String date = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController userNumber = new TextEditingController();

  bool _isLoad = false;

  void _trySubmit() async {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter name");
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter email");
    } else if (selectedValueExperience == null) {
      Fluttertoast.showToast(msg: "Select experience");
    } else if (date == "") {
      Fluttertoast.showToast(msg: "Select Date of Birth");
    } else if (weight.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter weight");
    } else if (height.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter height");
    } else if (selectedValueGoal == null) {
      Fluttertoast.showToast(msg: "Select goal");
    } else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).registerApi(
          phone: userNumber.text,
          email: email.text,
          name: name.text,
          location: "",
          workOutExperience: selectedValueExperience,
          gender: dropdownValueGender,
          dob: selectedDate.toString(),
          weight: weight.text,
          height: height.text,
          goal: selectedValueGoal);
      setState(() {
        _isLoad = false;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2035),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = selectedDate.year.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.day.toString();
      });
  }

  void number() async {
    var phone = await SharedPrefManager.getPrefrenceString(AppConstant.NUMBER);
    userNumber.text = phone;
  }

  String dropdownValue = '10 kg';
  var selectedValue = "";

  List<String> spinnerItems = ['10 kg', '12 kg'];

  String dropdownValueHeight = '4.5';
  var selectedValueHeight = "";

  List<String> spinnerItemsHeight = ['4.5', '5.6'];

  var selectedValueExperience;

  List<String> spinnerItemsExperience = ['4', '5'];

  String dropdownValueGender = 'Male';
  var selectedValueGender = "";

  List<String> spinnerItemsGender = ['Male', 'Female'];

  // String dropdownValueGoal = 'Weight Loose';
  var selectedValueGoal;

  List<String> spinnerItemsGoal = ['Weight Loose', 'Weight Gain'];

  @override
  void initState() {
    number();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/spalsh.jpg")),
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Setup Your Profile",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 2,
                  width: 60,
                  color: Colors.redAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      TextFormField(
                          controller: name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 17, color: Colors.white),
                              labelText: "First Name & Last Name*",
                              labelStyle: TextStyle(color: Colors.white),
                              // hintText: "Name/Business Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15))),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          // enabled: false,
                          controller: userNumber,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 17, color: Colors.white),
                              labelText: "Mobile*",
                              labelStyle: TextStyle(color: Colors.white),
                              enabled: false,
                              // hintText: "Name/Business Name",
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15))),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          controller: email,
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontSize: 17, color: Colors.white),
                              labelText: "Email*",
                              labelStyle: TextStyle(color: Colors.white),
                              // hintText: "Name/Business Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF363434)),
                                  borderRadius: BorderRadius.circular(30)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFF363434)),
                                  borderRadius: BorderRadius.circular(30)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15))),
                      /*SizedBox(height: 30,),

                      TextFormField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white),
                              labelText: "Location*",
                              labelStyle: TextStyle(
                                  color: Colors.white
                              ),
                              // hintText: "Name/Business Name",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0XFFFFFFFF)),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 15)
                          )
                      ),*/
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white)),
                        padding: EdgeInsets.only(left: 14, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValueExperience,
                          hint: Text(
                            "Workout Experience Level",
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String data) {
                            setState(() {
                              selectedValueExperience = data;
                            });
                          },
                          items: spinnerItemsExperience
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        date == "" ? "DOB" : date,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 15,
                                      bottom: 0,
                                      top: 0,
                                      child: Icon(
                                        Icons.calendar_today,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.white)),
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValueGender,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                underline: Container(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                onChanged: (String data) {
                                  setState(() {
                                    dropdownValueGender = data;
                                  });
                                },
                                items: spinnerItemsGender
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                                controller: weight,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                    labelText: "Weight*",
                                    labelStyle: TextStyle(color: Colors.white),
                                    // hintText: "Name/Business Name",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 15))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                                controller: height,
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                    labelText: "Height*",
                                    labelStyle: TextStyle(color: Colors.white),
                                    // hintText: "Name/Business Name",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFFFFFFFF)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 15))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white)),
                        padding: EdgeInsets.only(left: 14, right: 8),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValueGoal,
                          hint: Text(
                            "Choose your goal",
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String data) {
                            setState(() {
                              selectedValueGoal = data;
                            });
                          },
                          items: spinnerItemsGoal
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (_isLoad)
                        CircularProgressIndicator()
                      else
                        GestureDetector(
                          onTap: _trySubmit,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 0,
                              bottom: 10,
                            ),
                            // width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Center(
                              child: Text(
                                "NEXT",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
