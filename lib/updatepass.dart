import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_project/dashbord.dart';

Future<User> updateUserPassword(
  BuildContext context,
  String password,
  String confirmpassword,
) async {
  if (password != confirmpassword) {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return const CustomAlertDialog(
          title: "Password and Confirmpassword are not the Same",
          color: Color(0xffff6e1e),
        );
      },
    );
  } else {
    final response = await http.put(
      Uri.parse('https://mobilebackend.onrender.com/api/userpass'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));

      showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return const CustomAlertDialog(
            title: "Password is successfully changed",
            color: Color(0xff3afc33),
          );
        },
      );

      return User(email: "", password: "");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return const CustomAlertDialog(
            title: "Failed to change Password",
            color: Color(0xffff2222),
          );
        },
      );
    }
  }
  return User(email: "", password: "");
}

class User {
  final String email;
  final String password;

  const User({required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }
}

class UpdateUserP extends StatefulWidget {
  @override
  State<UpdateUserP> createState() => _UpdateUserPState();
}

class _UpdateUserPState extends State<UpdateUserP> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _confirmemailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();

  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Change Password !"),
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _passwordcontroller,
                    decoration:
                        const InputDecoration(hintText: 'Change password'),
                  ),
                  TextField(
                    controller: _confirmpasswordcontroller,
                    decoration:
                        const InputDecoration(hintText: 'Confirm password'),
                  ),

                  // inputFile(label: "email", obscureText: true),
                  // inputFile(label: "Confirm email", obscureText: true),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  color: const Color(0xff0054FF),
                  onPressed: () {
                    print("Updating password");

                    print(_passwordcontroller.text);
                    print(_confirmpasswordcontroller.text);

                    setState(() {
                      _futureUser = updateUserPassword(
                          context,
                          _passwordcontroller.text,
                          _confirmpasswordcontroller.text);
                    });
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));
                  },
                  // defining the shape
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0xff0054FF),
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text("Update Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
              ),
            ),
          ],
        )));
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

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: widget.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            "${widget.title}",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          /*      Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashbord()));
                print("hello");
              },
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
