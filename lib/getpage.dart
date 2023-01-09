import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Calendar.dart';
import 'package:mobile_project/Profil.dart';

List data = [];

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future<List> getData() async {
    final response = await http
        .get(Uri.parse('https://mobilebackend.onrender.com/api/users'));
    data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
        title: const Text("House Keeper"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                padding: EdgeInsets.only(top: 40, bottom: 60),
                itemCount: data.length == 0 ? 0 : data.length,
                itemBuilder: (context, index) {
                  return Center(
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue,
                                        Color.fromRGBO(0, 0, 150, 1)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        blurRadius: 12,
                                        offset: Offset(0, 6),
                                      )
                                    ]),
                              ),
                              Positioned.fill(
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalendarPage()));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            child: Image.asset(
                                              'assets/person.png',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Text(
                                                  data[index]["name"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Avenir',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text(
                                                  data[index]["state"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Avenir',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.location_on,
                                                    color: Colors.white,
                                                    size: 16),
                                                Text(
                                                  data[index]["location"],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Avenir',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "4.7",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 35.0),
                                              child: Row(
                                                children:
                                                    List.generate(1, (index) {
                                                  return Icon(Icons.star,
                                                      color: Colors.white);
                                                }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )));
                });
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Color.fromRGBO(0, 0, 128, 1),
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    ],
                  )))),
    );
  }
}
