import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Calendar.dart';
import 'package:mobile_project/Profil.dart';
import 'package:mobile_project/dashbord.dart';
import 'package:mobile_project/updatemail.dart';
import 'package:mobile_project/updatepass.dart';
import 'globals.dart' as globals;

class User {
  final String age;
  final String state;
  final String name;
  final String phoneNumber;
  final String location;

  const User({
    required this.age,
    required this.state,
    required this.name,
    required this.phoneNumber,
    required this.location,
  });
}

var data = [];
Future<List> getdata() async {
  final response = await http
      .get(Uri.parse('https://mobilebackend.onrender.com/api/getfav'));
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    print("this data ");
    print(data);
  }
  else{
    print(response.body);
    return data;
  }
  return data;
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 7, 97, 171),
          onPressed: () {},
          child: const Icon(Icons.favorite)),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 7, 97, 171),
        title: const Text("Favorite"),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<List<dynamic>>(
          future: getdata(),
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
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            "https://www.pngitem.com/pimgs/m/111-1114839_circle-people-icon-flat-png-avatar-icon-transparent.png",
                          ),
                        ),
                        title: Text(data[index]["name"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(data[index]["location"]),
                            SizedBox(
                                height:
                                    10), // Add some spacing between the sub titles
                            Text(data[index]["phoneNumber"]),
                            SizedBox(
                                height:
                                    10), // Add some spacing between the sub titles
                            Text(data[index]["age"]),
                            SizedBox(height: 10),
                            Visibility(
                              visible: data[index]["rate"] == 0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "New",
                                          style:
                                              TextStyle(color: Colors.blueAccent),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: data[index]["rate"] != 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${data[index]["rate"]}",
                                          style:
                                              TextStyle(color: Colors.blueAccent),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.blueAccent, size: 15)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
// Add some spacing between the sub titles
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: true
                                  ? const Icon(Icons.favorite, color: Colors.red)
                                  : const Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        onTap: () {
                          globals.id = data[index]["id"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalendarPage()));
                        },
                      ),
                    );
                  });
            }
          },
        ),
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
                                                      UpdateUserE()));
                                        },
                                        child: Text("Update Password")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateUserP()));
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
