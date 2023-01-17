import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'signup.dart';
import 'getpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //<-- SEE HERE
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please Sign in or Sign up to continue using our app ! ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/welcome.jpg"))),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    color: Color(0xff0054FF),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xff0054FF),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text("Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                  // creating the signup button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff0054FF),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                          color: Color(0xff0054FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
