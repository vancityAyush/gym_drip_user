import 'package:flutter/material.dart';
import 'package:twsuser/main.dart';
import 'package:twsuser/screen/homes.dart';
import 'package:twsuser/screen/homescreen.dart';

class OrderPlaced extends StatefulWidget {

  // OrderPlaced({this.id,this.margin,this.userPrice,this.shippingCharge,this.totalpayable,this.totalPrice,this.discount});

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        title: Text("Order Placed",
        style: TextStyle(
          fontFamily: "Proxima Nova",
          fontSize: 17*MediaQuery.of(context).textScaleFactor,
          fontWeight: FontWeight.w600,
          color: Color(0xFF262626)
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: <Widget>[

              Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/checkmark.png",width: 35,height: 35,)),

              Padding(
                padding: const EdgeInsets.only(top: 5,left: 20,right: 20,bottom: 5),
                child: Text("You Subscription had been taken successfully}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18*MediaQuery.of(context).textScaleFactor,
                      fontFamily: "Proxima Nova",
                      color: Color(0xFF262626)
                  ),),
              ),

              ElevatedButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);},child: Text("Home")),
              Container(
                height: 9,
                margin: EdgeInsets.only(bottom: 12),
                color: Color(0xFFF5F5F5),),


            ],
          ),
        ),
      ),
    );
  }
}