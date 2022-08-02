import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/AppConstant.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/apiService/sharedprefrence.dart';
import 'package:twsuser/screen/mysubcription.dart';
import 'package:twsuser/screen/pdf_view_page.dart';
import 'package:twsuser/screen/trainerpreview.dart';

import '../dummypage.dart';
import 'myprofile.dart';

class AccountFragment extends StatefulWidget {
  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  bool isLoad = false;
  var userName, gender, image;

  void referCode() async {
    userName = await SharedPrefManager.getPrefrenceString(AppConstant.NAME);
    image = await SharedPrefManager.getPrefrenceString(AppConstant.IMAGE);
    gender = await SharedPrefManager.getPrefrenceString(AppConstant.GENDER);
  }

  TextEditingController controllerRefeCode = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        referCode();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerRefeCode.dispose();
    super.dispose();
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
        centerTitle: true,
        title: Text(
          "Account",
          style: TextStyle(
              fontSize: 22 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/spalsh.jpg"),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 90),
                        child: Card(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        userName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(gender == null ? "" : gender),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 53,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Color(0XFFFE9900),
                            radius: 58,
                            backgroundImage: image == null
                                ? AssetImage("assets/images/spalsh.jpg")
                                : NetworkImage(
                                    "http://fitnessapp.frantic.in/" + image),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyProfile()));
                      },
                      leading: Image.asset(
                        "assets/images/user.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "My Account",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TrainerPreview()));
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BlankExerCise()));
                      },
                      leading: Image.asset(
                        "assets/images/dumbell.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "My Trainers",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MySubscription()));
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BlankExerCise()));
                      },
                      leading: Image.asset(
                        "assets/images/newsubscrip.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "My Subscriptions",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MySubscription()));
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BlankExerCise()));
                      },
                      leading: Image.asset(
                        "assets/images/report.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Progress Report",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (ctx) => StatefulBuilder(
                                  builder: (context, setState) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Container(
                                              height: 300,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 20, 10, 10),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "Enter Trainer's Referral Code",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                            color: Color(
                                                                0XFF2CB3BF)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          controllerRefeCode,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .always,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0XFF262626)),
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor:
                                                            Color(0XFFF2F2F2),
                                                        filled: true,
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Eg: TWS0000011PS",
                                                      ),
                                                      onSaved:
                                                          (String value) {},
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      "Trainer's referal code is the code given by your trainer to access the premium account to team with someone",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF8F9190),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    if (isLoad)
                                                      CircularProgressIndicator()
                                                    else
                                                      GestureDetector(
                                                        onTap: () async {
                                                          setState(() {
                                                            isLoad = true;
                                                          });
                                                          await Provider.of<
                                                                      ApiManager>(
                                                                  context,
                                                                  listen: false)
                                                              .useRefCodeApi(
                                                                  controllerRefeCode
                                                                      .text,
                                                                  context);
                                                          setState(() {
                                                            isLoad = false;
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0XFF2CB3BF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: Center(
                                                            child: Text(
                                                              "Enter trainer's Referral Code",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                ));
                      },
                      leading: Image.asset(
                        "assets/images/research.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Enter Referal Code",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentDetails()));
                      },
                      leading: Image.asset(
                        "assets/images/help.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Help Desk",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 1,
                      color: Color(0XFF838383),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => PDFViewPage(
                              title: "Terms & Conditions",
                              path: "assets/terms_and_condition.pdf",
                            ),
                          ),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/terms.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Terms & Condition",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => PDFViewPage(
                              title: "FAQ",
                              path: "assets/faq.pdf",
                            ),
                          ),
                        );
                      },
                      leading: Image.asset(
                        "assets/images/faq.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "FAQ",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      leading: Image.asset(
                        "assets/images/priv.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Privacy Policies",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => DummyPage()));
                      },
                      leading: Image.asset(
                        "assets/images/priv.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Dummy Page",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF767676),
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.double_arrow_rounded),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 1,
                        color: Color(0XFF838383)),
                    ListTile(
                      onTap: () async {
                        await SharedPrefManager.clearPrefs();
                      },
                      leading: Image.asset(
                        "assets/images/logout.png",
                        width: 27,
                        height: 27,
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            color: Color(0XFF5A5A5A),
                            fontWeight: FontWeight.normal),
                      ),
                      // trailing: Icon(Icons.double_arrow_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
