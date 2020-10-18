import 'package:flutter/material.dart';
import 'package:maniva/components/app_drawer.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text("About Us", style: TextStyle(color: Colors.black),),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Container(
          child: Text("About us"),
        ),
      ),
    );
  }
}