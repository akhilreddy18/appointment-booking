import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maniva/screens/appointments/event_calender.dart';
import 'package:maniva/screens/home_screen.dart';
import 'package:maniva/screens/authentication/login_screen.dart';
import 'package:maniva/providers/user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => User.instance(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          MyHomePage.routeName: (ctx) => MyHomePage(),
          EventCalender.routeName: (ctx) => EventCalender(),
        },
      ),
    );
  }
}
