import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/Favorie.dart';

import 'package:mobile_project/History.dart';

import 'package:mobile_project/Profil.dart';
import 'package:mobile_project/QrReader.dart';
import 'package:mobile_project/updatemail.dart';
import 'package:mobile_project/updatepass.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dashbord.dart';

import 'globals.dart' as globals;

import 'package:mobile_project/Appointments.dart';

import 'package:http/http.dart' as http;

import 'package:mobile_project/main.dart';

final colblue = Color.fromARGB(255, 7, 97, 171);

List data = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning

  // that it has a State object (defined below) that contains fields that affect

  // how it looks.

  // This class is the configuration for the state. It holds the values (in this

  // case the title) provided by the parent (in this case the App widget) and

  // used by the build method of the State. Fields in a Widget subclass are

  // always marked "final".

  // final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var logout = false;

  Signout() async {
    var url = "https://mobilebackend.onrender.com/api/signout";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        logout = true;
      } else {
        // If the server did not return a 201 CREATED response,

        // then throw an exception.

        throw Exception('${response.body}');
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  void log() async {
    {
      print(logout);

      var url = "https://mobilebackend.onrender.com/api/signout";

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          logout = true;
        } else {
          // If the server did not return a 201 CREATED response,

          // then throw an exception.

          throw Exception('${response.body}');
        }
      } catch (er) {
        throw Exception(er);
      }
    }

    print(logout);

    if (logout == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage())); // If the server did return a 200 OK response,

    }
  }

  void rating() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rating'),
          content: Text(
            (data[0]['rate'] == 0)
                ? 'No Rating Available yet'
                : 'Your Current Rating is : ${data[0]['rate']}',
            style: TextStyle(
              color: colblue,
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
  }

  void history() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
  }

  Future<List> getData() async {
    final response = await http
        .get(Uri.parse('https://mobilebackend.onrender.com/api/myprofil'));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
    }

    print(data);

    return data.toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    // by the _incrementCounter method above.

    //

    // The Flutter framework has been optimized to make rerunning build methods

    // fast, so that you can just rebuild anything that needs updating rather

    // than having to individually change instances of widgets.

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: colblue,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoritePage()));
          },
          child: const Icon(Icons.favorite)),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
                child: Column(
              children: [
                //Stack Container

                Container(
                  height: MediaQuery.of(context).size.height * 0.31,
                  child: Stack(children: [
                    Container(),
                    ClipPath(
                      clipper: MyCustomClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        color: colblue,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Align(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          CircularProfileAvatar(
                            "https://www.pngitem.com/pimgs/m/111-1114839_circle-people-icon-flat-png-avatar-icon-transparent.png",
                            borderWidth: 4.0,
                            radius: 60,
                          ),
                          Text(
                            data[0]['name'],
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            globals.email,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.48,

                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 21.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: rating,
                                  icon: Icon(
                                    Icons.star,
                                    size: 40.0,
                                    color: colblue,
                                  ),
                                ),
                                SizedBox(width: 24.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 21.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: history,
                                  icon: Icon(
                                    Icons.history,
                                    size: 40.0,
                                    color: colblue,
                                  ),
                                ),
                                SizedBox(width: 24.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'history',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 21.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QRPage(
                                                title:
                                                    "Valid a finishing Appointement")));
                                  }),
                                  icon: Icon(
                                    Icons.history,
                                    size: 40.0,
                                    color: colblue,
                                  ),
                                ),
                                SizedBox(width: 24.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Scan',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 21.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: log,
                                  icon: Icon(
                                    Icons.logout,
                                    size: 40.0,
                                    color: colblue,
                                  ),
                                ),
                                SizedBox(width: 24.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'logout',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Color.fromARGB(255, 7, 97, 171),
          child: IconTheme(
              data: IconThemeData(
                  color: Theme.of(context).colorScheme.onSecondary),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashbord()));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.list),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Appointments()));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Settings'),
                                content: Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateUserP()));
                                        },
                                        child: Text("Update Password")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateUserE()));
                                        },
                                        child: Text("Update Email")),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  )))),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height - 150);

    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
