import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Status> createUser(String email) async {
  final response = await http.post(
    Uri.parse('https://mobilebackend.onrender.com/api/forgetPassword'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Status.fromJson(jsonDecode(response.body));

  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to reset password.');
  }
}

class User {
  final String email;

  const User({ required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],

    );
  }
}


class Status {
  final String status;

  const Status({ required this.status});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      status: json['status'],

    );
  }
}



class ForgetPassword extends StatefulWidget {

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailcontroller = TextEditingController();

  Future<Status>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reset password',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Reset Password'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(hintText: 'Enter Email'),
              ),
              // inputFile(label: "Email"),
              // inputFile(label: "Password", obscureText: true)
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print(_emailcontroller.text);

            setState(() {
              _futureUser = createUser(_emailcontroller.text);
            });
          },
          child: const Text('Sent'),
        ),
      ],
    );
  }

  FutureBuilder<Status> buildFutureBuilder() {
    return FutureBuilder<Status>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.status);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}