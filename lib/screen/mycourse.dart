// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  Function goToTab;
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        backgroundColor: Colors.white,
        backgroundBlendMode: BlendMode.colorDodge,
        backgroundImage: "assets/images/spalsh.jpg",
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: Colors.white,
        backgroundBlendMode: BlendMode.colorDodge,
        backgroundImage: "assets/images/spalsh.jpg",
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: Colors.white,
        backgroundBlendMode: BlendMode.colorDodge,
        backgroundImage: "assets/images/spalsh.jpg",
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: Colors.white,
        backgroundBlendMode: BlendMode.colorDodge,
        backgroundImage: "assets/images/spalsh.jpg",
      ),
    );
  }

  void onDonePress() {
    this.goToTab(0);
  }

  void onTabChangeCompleted() {}

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      size: MediaQuery.of(context).size.height,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      tabs.add(Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
              ),
              Container(),
              Container(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Text(
          "My Courses",
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: IntroSlider(
                  slides: this.slides,
                  showDoneBtn: false,
                  showNextBtn: false,
                  showSkipBtn: false,
                  showPrevBtn: false,
                  colorActiveDot: Colors.redAccent,
                  colorDot: Colors.white,
                  stylePrevBtn: TextStyle(color: Colors.white),
                  styleDoneBtn: TextStyle(color: Colors.white),
                  styleSkipBtn: TextStyle(color: Colors.white),
                  onDonePress: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Upgrade to TWS premium",
              style: TextStyle(
                  fontSize: 21 * MediaQuery.of(context).textScaleFactor,
                  color: Color(0XFF4E4E4E),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "and get all benefits at one place",
              style: TextStyle(
                  fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                  color: Color(0XFF4E4E4E),
                  fontWeight: FontWeight.normal),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      "Customized Diet Plan",
                      style: TextStyle(
                          fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                          color: Color(0XFF4E4E4E),
                          fontWeight: FontWeight.normal),
                    ),
                  );
                }),
            GestureDetector(
              onTap: () {
                return showDialog(
                    context: context,
                    builder: (ctx) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0)),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              height: 330,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Enter Trainer's Referral Code?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.redAccent),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          style: TextStyle(
                                              color: Color(0XFF262626)),
                                          decoration: InputDecoration(
                                            fillColor: Color(0XFFF2F2F2),
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText:
                                                "Enter Trainer's Referral Code",
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
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "Trainer's referral code is the code given by your trainer to access the premium account of team with someone",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0XFFAEAEAE)),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.only(
                                              top: 30,
                                            ),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.redAccent),
                                            child: Center(
                                              child: Text(
                                                "SUBMIT",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent),
                child: Center(
                  child: Text(
                    "Enter Trainer's Referral Code",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.redAccent,
                      filled: true,
                      hintText: "Enter Trainer's Referral Code",
                      hintStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      labelStyle: TextStyle(
                          color: Colors.white),
                      // hintText: "Name/Business Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20)
                  ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
