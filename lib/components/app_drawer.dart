import 'package:flutter/material.dart';
import 'package:maniva/screens/about_us.dart';
import 'package:maniva/screens/appointments/event_calender.dart';
import 'package:maniva/screens/home_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 130,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Text('Maniva Digital', style: TextStyle(
                fontSize: 22,
              ),),
              decoration: BoxDecoration(
                color: Colors.grey[400],
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                SlideRightRoute(
                  page: MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                SlideRightRoute(
                  page: AboutUs(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Book appointment'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                SlideRightRoute(
                  page: EventCalender(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
