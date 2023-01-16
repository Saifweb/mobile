import 'package:flutter/material.dart';

import 'package:mobile_project/SearchPage.dart';

import 'dart:ui';

import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:mobile_project/dashbord.dart';

import 'globals.dart' as globals;

var currentStep = 0;

var _selectedValue;

final _stateController = TextEditingController();

Future<User> createUser(
  BuildContext context,
  String name,
  String email,
  String state,
  String phoneNumber,
  String location,
  String password,
  String confirmpassword,
  String age,
) async {
  if (password != confirmpassword) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
            "Password No Match !",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            TextButton(
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
          'location': location,
          'phoneNumber': phoneNumber,
          'password': password,
          'age': age,
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
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                response.body,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ); // If the server did not return a 201 CREATED response,

        // then throw an exception.

        return User(email: "", password: "", name: "", state: "");
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
              TextButton(
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

  final TextEditingController _locationcontroller = TextEditingController();

  final TextEditingController _phoneNumbercontroller = TextEditingController();

  final TextEditingController _agecontroller = TextEditingController();

  Future<User>? _futureUser;

  List<Step> getSteps(
          _namecontroller,
          _emailcontroller,
          _statecontroller,
          _phoneNumbercontroller,
          _locationcontroller,
          _passwordcontroller,
          _confirmpasswordcontroller,
          _agecontroller) =>
      [
        Step(
            isActive: currentStep >= 0,
            title: Text("Step 1"),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: _namecontroller,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                ),

                TextField(
                  controller: _emailcontroller,
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                ),

                TextField(
                  controller: _stateController,
                ),
                DropdownButton<String>(
                  value: _selectedValue,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    _stateController.text = newValue!;
                  },
                  items: <String>['housekeeper', 'customer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                // TextField(

                //   controller: _statecontroller,

                //   decoration: const InputDecoration(hintText: 'Enter State'),

                // ),
              ],
            )),
        Step(
            isActive: currentStep >= 1,
            title: Text("Step 2"),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: _locationcontroller,
                  decoration: const InputDecoration(hintText: 'Enter Location'),
                ),
                TextField(
                  controller: _phoneNumbercontroller,
                  decoration:
                      const InputDecoration(hintText: 'Enter phoneNumber'),
                ),
                TextField(
                  controller: _agecontroller,
                  decoration: const InputDecoration(hintText: 'Enter age'),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text("Step 3"),
            content: Column(
              children: <Widget>[
                TextField(
                  obscureText: true,
                  controller: _passwordcontroller,
                  decoration: const InputDecoration(
                      labelText: 'Password', hintText: 'Enter Password'),
                ),
                TextField(
                  obscureText: true,
                  controller: _confirmpasswordcontroller,
                  decoration: const InputDecoration(
                      labelText: 'Password', hintText: 'Confirm Password'),
                ),
              ],
            )),
      ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xff0054FF),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: Color(0xff0054FF))),
              child: Stepper(
                controlsBuilder: ((context, details) {
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          child: Text("Next"),
                          onPressed: details.onStepContinue,
                        )),
                        const SizedBox(width: 12),
                        if (currentStep != 0)
                          Expanded(
                              child: ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: details.onStepCancel,
                          )),
                      ],
                    ),
                  );
                }),
                type: StepperType.horizontal,
                steps: getSteps(
                    _namecontroller,
                    _emailcontroller,
                    _stateController,
                    _phoneNumbercontroller,
                    _locationcontroller,
                    _passwordcontroller,
                    _confirmpasswordcontroller,
                    _agecontroller),
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (currentStep != 2) {
                      currentStep += 1;
                    } else {
                      globals.email = _emailcontroller.text;

                      //send Data!

                      _futureUser = createUser(
                          context,
                          _namecontroller.text,
                          _emailcontroller.text,
                          _stateController.text,
                          _phoneNumbercontroller.text,
                          _locationcontroller.text,
                          _passwordcontroller.text,
                          _confirmpasswordcontroller.text,
                          _agecontroller.text);
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep != 0) {
                      currentStep -= 1;
                    }
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
