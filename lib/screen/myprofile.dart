// @dart=2.9
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apiResponse/ResponseProfile.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/questionfitness.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Data data = Data();
  String imageUrl;
  String imageLocal;
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController contactDetailController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();

  void _trySubmit() async {
    bool res =
        await Provider.of<ApiManager>(context, listen: false).editProfileApi(
            name: nameController.text,
            gender: genderController.text,
            dob: ageController.text,
            weight: weightController.text,
            height: heightController.text,
            goal: goalController.text,
            occupations: occupationController.text,
            //contactDetailController.text,
            relationship_status: relationshipController.text,
            imagePath: imageLocal);
    if (res) {
      Fluttertoast.showToast(
          msg: "Profile Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else
      Fluttertoast.showToast(
          msg: "Profile Not Updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
  }

  void fetchProfile() async {
    var future =
        Provider.of<ApiManager>(context, listen: false).fetchProfileApi();
    future.then((value) {
      var height = value['data']['height'].split(".");
      var weight = value['data']['weight'].split(".");
      setState(() {
        print(value['data']['name']);
        nameController.text = value['data']['name'];
        genderController.text = value['data']['gender'];
        ageController.text = value['data']['dob'];
        weightController.text = weight[0].toString();
        heightController.text = height[0].toString();
        goalController.text = value['data']['goal'];
        occupationController.text = value['data']['occupations'];
        contactDetailController.text = value['data']['phone'];
        relationshipController.text = value['data']['relationship_status'];
        imageUrl = "http://fitnessapp.frantic.in/" + value['data']['image'];
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      fetchProfile();
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    goalController.dispose();
    occupationController.dispose();
    contactDetailController.dispose();
    relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Colors.white),
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
          children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 8, bottom: 0, right: 20, left: 20),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Basic Profile",
                    style: TextStyle(
                        fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      ImagePicker()
                          .getImage(source: ImageSource.gallery)
                          .then((value) {
                        setState(() {
                          print(value);
                          imageUrl = null;
                          imageLocal = value.path;
                        });
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: imageUrl == null && imageLocal == null
                          ? AssetImage("assets/images/spalsh.jpg")
                          : imageLocal == null
                              ? NetworkImage(imageUrl)
                              : FileImage(File(imageLocal)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.always,
                    style: TextStyle(color: Color(0XFF262626)),
                    decoration: InputDecoration(
                      fillColor: Color(0XFFF2F2F2),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Name",
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                            "Age",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                          controller: genderController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Gender",
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
                          controller: ageController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Age",
                          ),
                          onSaved: (String value) {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                            "Height",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: weightController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Weight",
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: heightController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Height",
                          ),
                          onSaved: (String value) {},
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Goal",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                            "Occupation",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                          controller: goalController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Goal",
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
                          controller: occupationController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Occupation",
                          ),
                          onSaved: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Contact Details",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                            "Relationship Status",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
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
                          controller: contactDetailController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Contact Details",
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
                          controller: relationshipController,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Color(0XFF262626)),
                          decoration: InputDecoration(
                            fillColor: Color(0XFFF2F2F2),
                            filled: true,
                            border: InputBorder.none,
                            hintText: "Relationship Status",
                          ),
                          onSaved: (String value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: _trySubmit,
              child: Container(
                margin:
                    EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                // width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: Text(
                    "UPDATE",
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
            GestureDetector(
              onTap: () async {
                var future =
                    await Provider.of<ApiManager>(context, listen: false)
                        .questionApi();
                if (future.data[0].answer == null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionFitness()));
                } else {
                  Fluttertoast.showToast(
                      msg: "You have already given these physical question");
                }
              },
              child: Container(
                height: 120,
                margin: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.redAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Complete your",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          // SizedBox(height: 7,),
                          Text(
                            "Fitness Profile",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Has your doctor ever said that you have a heart "
                       ,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),),
                  ),

                  SizedBox(height: 7,),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    style: TextStyle(color: Color(0XFF262626)),
                    enabled: false,
                    decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                      border: InputBorder.none,
                      hintText: "Yes, No",),

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

                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Has your doctor ever said that you have a heart "
                      ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                  ),

                  SizedBox(height: 7,),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    style: TextStyle(color: Color(0XFF262626)),
                    enabled: false,
                    decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                      border: InputBorder.none,
                      hintText: "Yes, No",),

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

                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Has your doctor ever said that you have a heart "
                      ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                  ),

                  SizedBox(height: 7,),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    style: TextStyle(color: Color(0XFF262626)),
                    enabled: false,
                    decoration: InputDecoration(fillColor: Color(0XFFF2F2F2), filled: true,
                      border: InputBorder.none,
                      hintText: "Yes, No",),

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

                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Subscription Detail"
                      ,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                  ),

                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top:20,bottom: 20,),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                Icon(Icons.watch_later_outlined,color: Color(0XFFD0D0D0),
                                  size: 15,),

                                SizedBox(width: 6,),

                                Text("Next Billing Date",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0XFFD0D0D0)
                                  ),)
                              ],
                            ),

                            Text("17 August, 2020",
                              style: TextStyle(
                                  fontSize: 18*MediaQuery.of(context).textScaleFactor,
                                  color: Color(0XFF5C5C5C),
                                  fontWeight: FontWeight.w600
                              ),),

                          ],
                        ),

                        SizedBox(height: 20,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Subscription Details",style: TextStyle(
                              fontSize: 19*MediaQuery.of(context).textScaleFactor,
                              color: Color(0XFF4E4E4E),
                              fontWeight: FontWeight.w600
                          ),),
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

                        SizedBox(height: 9,),

                        Text("Lorem Ipsum ipsum sjds ja dioc soid aof ro of idfs oic siodn cks i",style: TextStyle(
                            color: Color(0XFFA3A3A3),
                            fontWeight: FontWeight.normal,
                            fontSize: 15
                        ),),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: Icon(Icons.check,color: Colors.redAccent,),
                                title: Text("2599 standard plan",style: TextStyle(
                                    fontSize: 16*MediaQuery.of(context).textScaleFactor,
                                    color: Color(0XFF4E4E4E),
                                    fontWeight: FontWeight.normal
                                ),),
                              );
                            }),*/

/*GestureDetector(
                    onTap: (){},
                    child: Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                        child: Text("SUBMIT",style: TextStyle(
                            fontSize: 21*MediaQuery.of(context).textScaleFactor,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),*/
// ],
// ),
// ),
