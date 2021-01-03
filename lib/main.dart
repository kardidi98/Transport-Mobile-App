import 'package:animated_splash/animated_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'file:///C:/flutter_workspace/transport_app/lib/screens/afterSplash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trans-App',
      home: MyHomePage(title: 'Trans-App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: 150.0),
          child: Center(
            child: AnimatedSplash(
              imagePath: 'images/logo.png',
              home: new MyAppAfterSplash(),
              duration: 5000,
              type: AnimatedSplashType.StaticDuration,
            ),
          ),
        ));
  }
}
