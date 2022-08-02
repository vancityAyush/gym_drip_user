import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:twsuser/twsuser/login.dart';

class IntroSliders extends StatefulWidget {
  @override
  _IntroSlidersState createState() => _IntroSlidersState();
}

class _IntroSlidersState extends State<IntroSliders> {
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
    slides.add(new Slide(
      backgroundColor: Colors.white,
      backgroundBlendMode: BlendMode.colorDodge,
      backgroundImage: "assets/images/spalsh.jpg",
    ));
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
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      tabs.add(Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
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
        body: new IntroSlider(
            slides: this.slides,
            stylePrevBtn: TextStyle(color: Colors.black),
            styleDoneBtn: TextStyle(color: Colors.black),
            styleSkipBtn: TextStyle(color: Colors.black),
            onDonePress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }));
  }
}
