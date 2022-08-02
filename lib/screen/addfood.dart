import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';

class AddFood extends StatefulWidget {
  final String id;

  AddFood({this.id});

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String selectedValue, foodName;

  TextEditingController foodController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController carbController = TextEditingController();
  TextEditingController fatController = TextEditingController();

  bool _isLoad = false;

  void _trySubmit() async {
    if (foodController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter food", gravity: ToastGravity.BOTTOM);
    } else if (proteinController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter protein", gravity: ToastGravity.BOTTOM);
    } else if (carbController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter carbs", gravity: ToastGravity.BOTTOM);
    } else if (fatController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter fats", gravity: ToastGravity.BOTTOM);
    } else {
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ApiManager>(context, listen: false).addFoodApi(
          foodController.text,
          proteinController.text,
          carbController.text,
          fatController.text,
          widget.id);
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  void dispose() {
    foodController.dispose();
    proteinController.dispose();
    carbController.dispose();
    fatController.dispose();
    super.dispose();
  }

  final String loremIpsum = "Bread , Apple , Banana ,";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
        title: Text(
          "Add Food",
          style: TextStyle(
              fontSize: 17 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
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
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Food Name",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent),
                  ),
                ),
              ),
              Column(
                children: [
                  TextFormField(
                      controller: foodController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize:
                                17 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.redAccent),
                        labelText: "Enter food name",
                        labelStyle: TextStyle(color: Colors.redAccent),
                        // hintText: "Name/Business Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: proteinController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize:
                                17 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.redAccent),
                        labelText: "Enter protein",
                        labelStyle: TextStyle(color: Colors.redAccent),
                        // hintText: "Name/Business Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: carbController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize:
                                17 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.redAccent),
                        labelText: "Enter carbs",
                        labelStyle: TextStyle(color: Colors.redAccent),
                        // hintText: "Name/Business Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: fatController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize:
                                17 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.redAccent),
                        labelText: "Enter fats",
                        labelStyle: TextStyle(color: Colors.redAccent),
                        // hintText: "Name/Business Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF363434)),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              if (_isLoad)
                CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: () => _trySubmit(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Add Food",
                        style: TextStyle(
                            fontSize:
                                21 * MediaQuery.of(context).textScaleFactor,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
