import 'package:flutter/material.dart';
import 'package:mobile_project/SearchPage.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/dashbord.dart';

Future<User> createUser(
  BuildContext context,
  String name,
  String email,
  String state,
  String password,
  String confirmpassword,
) async {
  if (password != confirmpassword) {
    throw Exception('Wrong password');
  } else {
    try {
      final response = await http.post(
        Uri.parse('https://mobilebackend.onrender.com/api/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'state': state,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // return User.fromJson(jsonDecode(response.body));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashbord()));
        return User(email: "", password: "", name: "", state: "");
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to signup.');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              e.toString(),
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return User(email: "", password: "", name: "", state: "");
    }
  }
}

class User {
  final String email;
  final String password;
  final String name;
  final String state;

  const User(
      {required this.email,
      required this.password,
      required this.name,
      required this.state});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      state: json['state'],
      name: json['name'],
      password: json['password'],
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _statecontroller = TextEditingController();

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 7,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png"))),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, bottom: 160),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _namecontroller,
                        decoration:
                            const InputDecoration(hintText: 'Full Name'),
                      ),
                      TextField(
                        controller: _emailcontroller,
                        decoration:
                            const InputDecoration(hintText: 'Enter Email'),
                      ),
                      TextField(
                        controller: _statecontroller,
                        decoration:
                            const InputDecoration(hintText: 'Enter State'),
                      ),
                      TextField(
                        controller: _passwordcontroller,
                        decoration:
                            const InputDecoration(hintText: 'Enter Password'),
                      ),
                      TextField(
                        controller: _confirmpasswordcontroller,
                        decoration:
                            const InputDecoration(hintText: 'Confirm Password'),
                      ),
                      // inputFile(label: "Full Name",),
                      // inputFile(label: "Email"),
                      // inputFile(label: "State"),
                      // inputFile(label: "Password", obscureText: true),
                      // inputFile(label: "Confirm Password", obscureText: true),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40, left: 40, bottom: 80),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: Color(0xff0054FF),
                      onPressed: () {
                        print("making log in");

                        print(_emailcontroller.text);
                        print(_namecontroller.text);
                        print(_passwordcontroller.text);
                        print(_statecontroller.text);

                        print(_confirmpasswordcontroller.text);

                        setState(() {
                          _futureUser = createUser(
                              context,
                              _namecontroller.text,
                              _emailcontroller.text,
                              _statecontroller.text,
                              _confirmpasswordcontroller.text,
                              _passwordcontroller.text);
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));
                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color(0xff0054FF),
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text("Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({
  label,
  obscureText = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            )),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
