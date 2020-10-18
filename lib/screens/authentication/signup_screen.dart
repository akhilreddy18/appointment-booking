import 'package:flutter/material.dart';
import 'package:maniva/screens/home_screen.dart';
import 'package:maniva/providers/user.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  User user;
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    double height = MediaQuery.of(context).size.height;

    void handleSignup() async {
      String email = emailController.text;
      String password = passwordController.text;
      String rePassword = rePasswordController.text;
      if (password == rePassword) {
        try {
          await user.signIn(email, password);
          Navigator.of(context).popAndPushNamed(MyHomePage.routeName);
        } catch (e) {
          print(e);
          Scaffold.of(scaffoldContext).showSnackBar(
          SnackBar(
            content: Text('Some error occurred. Please try again!'),
            backgroundColor: Colors.red,
          ),
        );
        }
      } else {
        Scaffold.of(scaffoldContext).showSnackBar(
          SnackBar(
            content: Text('Email and password not matched'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    final emailField = TextFormField(
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      validator: (value) {
        if (value.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address.';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Enter email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      validator: (value) {
        if (value.isEmpty || value.length < 7) {
          return 'Password must be at least 7 characters long.';
        }
        return null;
      },
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Enter password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final reEnterPasswordField = TextFormField(
      validator: (value) {
        if (value.isEmpty || value.length < 7) {
          return 'Password must be at least 7 characters long.';
        }
        return null;
      },
      controller: rePasswordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Re-enter password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          handleSignup();
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (ctx) {
          scaffoldContext = ctx;
          return ListView(
            children: [
              Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: (100.0 / 820.57) * height,
                          child: Icon(Icons.computer),
                        ),
                        SizedBox(height: (45.0 / 820.57) * height),
                        emailField,
                        SizedBox(height: 25.0),
                        passwordField,
                        SizedBox(height: 25.0),
                        reEnterPasswordField,
                        SizedBox(
                          height: 35.0,
                        ),
                        signUpButton,
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
