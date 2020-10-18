import 'package:flutter/material.dart';
import 'package:maniva/components/app_drawer.dart';
import 'package:maniva/screens/appointments/event_calender.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = 'checkup-root';
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  BuildContext buildContext;

  Widget bookConsultationButton(BuildContext context) {
    return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color.fromARGB(255, 239, 161, 14),
    child: MaterialButton(
      minWidth: 200,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.of(context).pushNamed(EventCalender.routeName);
      },
      child: Text(
        "Book consulation",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("Homepage", 
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[800]
        ),),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                "Welcome to Maniva Digital",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 45,
                color: Color.fromARGB(255, 239, 161, 14)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Mobile App & Website Development",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "IT-Consultation",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Data Analysis",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 180,
              ),
              bookConsultationButton(context)
            ],
          ),
        ),
      ),
    );
  }
}
