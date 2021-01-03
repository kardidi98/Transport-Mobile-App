import 'package:flutter/material.dart';
import 'package:transport_app/screens/userPreferencesForm.dart';
import 'file:///C:/flutter_workspace/transport_app/lib/screens/home.dart';
import 'userForm.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class MyAppAfterSplash extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trans-App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: new Container(
          child: AfterSplash(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backG1.jpg"), fit: BoxFit.fill)),
        ));
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  int _currentIndex = 0;

  static List<Widget> _children = <Widget>[
    Home(),
    UserPreferencesForm(),
    UserForm(),
  ];
  Widget _child = _children.elementAt(0);

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleNavigationChange(int index) {
    setState(() {
      _child = _children.elementAt(index);

      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Trans-App'),
        ),
        body: _child, // new
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.home_outlined,
                backgroundColor: Colors.lightBlueAccent,
                extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.check_box_outlined,
                backgroundColor: Colors.teal,
                extras: {"label": "preferences"}),
            FluidNavBarIcon(
                icon: Icons.search,
                backgroundColor: Color(0xFFEC4134),
                extras: {"label": "search"}),

          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras["label"],
            child: item,
          ),
        ));
  }
}
