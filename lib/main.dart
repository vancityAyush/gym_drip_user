import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:twsuser/screen/homescreen.dart';
import 'package:twsuser/twsuser/introslider.dart';

import 'apiService/apimanager.dart';
import 'apiService/sharedprefrence.dart';
import 'routing/router.dart' as router;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget _default = new MyApp();
  bool status = await SharedPrefManager.getBooleanPreferences() != null;

  if (status == true) {
    _default = HomeScreen();
  }

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ApiManager(),
          ),
        ],
        child: Consumer<ApiManager>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: _default,
            onGenerateRoute: router.generateRoute,
            navigatorKey: navigatorKey,
          ),
        )),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellow,
        fontFamily: "Proxima Nova",
        /*buttonTheme: ButtonTheme.of().copyWith(
                buttonColor: Colors.blue,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))*/
      ),
      home: new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new IntroSliders(),
        imageBackground: AssetImage("assets/images/spalsh.jpg"),
        loaderColor: Colors.white,
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
