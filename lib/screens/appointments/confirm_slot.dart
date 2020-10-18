import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maniva/providers/user.dart';
import 'package:maniva/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AppointmentEditor extends StatefulWidget {
  final DateTime date;
  AppointmentEditor(this.date);
  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  User user;
  bool bookingSuccess = false;
  BuildContext scaffoldContext;
  List<String> availableSlots = [
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30"
  ];

  @override
  void didChangeDependencies() async {
    scaffoldContext = context;
    super.didChangeDependencies();
  }

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.only(top: 10),
        children: getSlots(),
      ),
    );
  }

  List<Widget> getSlots() {
    List<Widget> widgets = [];
    availableSlots.forEach(
      (slot) {
        widgets.add(
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.only(bottom: 5),
                  child: loginButon(slot)
                  /* FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      _showMyDialog(slot);
                    },
                    child: Text(slot),
                  ), */
                ),
              ],
            ),
          ),
        );
      },
    );
    return widgets;
  }

  Widget loginButon(slot) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: 100,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _showMyDialog(slot);
        },
        child: Text(slot,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _showMyDialog(String slot) async {
    return showDialog<void>(
      context: scaffoldContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm slot'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to book this slot?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await bookslot(slot);
                if (mounted) {
                  setState(() {
                    bookingSuccess = true;
                  });
                }
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(scaffoldContext)
                    .popAndPushNamed(MyHomePage.routeName);
              },
            ),
            FlatButton(
              child: Text('no'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future bookslot(String slot) {
    return FirebaseFirestore.instance
        .collection("appointments")
        .add({'id': user.id, 'date': widget.date, 'time': slot});
  }

  @override
  Widget build([BuildContext context]) {
    user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select time slot'),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: bookingSuccess
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('booking success..redirecting to homepage'),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
    );
  }
}
