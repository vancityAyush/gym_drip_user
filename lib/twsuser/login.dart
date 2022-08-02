import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var countries;
  final _formKey = GlobalKey<FormState>();
  var _userNumber = "";
  bool _isLoad = false;

  void _trySubmit() async{
    final isValid =_formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState?.save();
      setState(() {
        _isLoad = true;});
      await Provider.of<ApiManager>(context,listen: false).loginApi(_userNumber);
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    /*child: Column(
                  children: [
                    Image.asset("assets/images/phoned.png",)
                  ],*/
                    // ),
                  )),

              Expanded(flex:1,child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 60,right: 80),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      showCountryPicker(
                                        context: context,
                                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                        exclude: <String>['KN', 'MF'],
                                        showPhoneCode: true,
                                        onSelect: (Country country) {
                                          countries = country.displayName;
                                          print('Select country: ${country.displayName}');
                                        },);
                                    });
                                  },child: countries == null ? Text("India(+91)",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22*MediaQuery.of(context).textScaleFactor,
                                    color: Color(0XFF343138),)): Text(countries,
                                style: TextStyle(
                                  fontFamily: "Proxima Nova",
                                  fontWeight: FontWeight.w500,
                                  fontSize:22*MediaQuery.of(context).textScaleFactor,
                                  color: Color(0XFF343138),
                                ),)),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    showCountryPicker(
                                      context: context,
                                      exclude: <String>['KN', 'MF'],
                                      showPhoneCode: true,
                                      onSelect: (Country country) {
                                        countries = country.displayName;
                                        print('Select country: ${country.displayName}');
                                      },);});},
                                child: Icon(Icons.keyboard_arrow_down,
                                  size: 30,),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50,right: 50),
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Color(0XFFD6D5DB),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:50.0,right: 50),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          maxLines: 1,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter your mobile number';
                            }else if(value.length<10){
                              return 'Please input valid mobile number';}
                            return null;},
                          style: TextStyle(),
                          decoration: const InputDecoration(
                              hintText: 'Your Phone Number',
                              hintStyle: TextStyle(
                                  fontSize: 21,
                                  color: Color(0XFF8F8E85),
                                  fontWeight: FontWeight.w600
                              ),
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          onSaved: (value) {
                            _userNumber = value;},
                        ),
                      ],
                    ),),

                  Padding(
                    padding: const EdgeInsets.only(left:35.0,right: 35),
                    child: Text("We will send you a one time SMS message carrier rates may apply",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF929195),
                          fontSize: 18
                      ),),
                  ),

                  if(_isLoad)
                    CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: Colors.red,)
                  else
                    GestureDetector(
                      onTap: _trySubmit,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        child: Icon(Icons.double_arrow_rounded,
                          color: Colors.white,),
                      ),
                    ),
                ],
              ),
              ),
            ],
          ),
        )
    );
  }
}