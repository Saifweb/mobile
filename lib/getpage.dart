import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Calendar.dart';
import 'package:mobile_project/Favorie.dart';
import 'package:mobile_project/Profil.dart';
import 'package:mobile_project/dashbord.dart';
import 'package:mobile_project/updatemail.dart';
import 'package:mobile_project/updatepass.dart';
import 'globals.dart' as globals;

List data = [];
var Fav = [];
List AuthUser = [];

AddFav(BuildContext context, fav) async {
  var url = "https://mobilebackend.onrender.com/api/addfav";
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fav': fav,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavoritePage()));
      // If the server did return a 200 OK response,
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("error");
    }
  } catch (er) {
    print("error");
  }
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  getUser() async {
    var url = "https://mobilebackend.onrender.com/api/myprofil";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      AuthUser = json.decode(response.body);
      print(AuthUser[0]["name"]);
      Fav = AuthUser[0]["fav"];
      print(Fav);
    } else {
      print("e");
    }
  }

  // This list holds the data for the list view

  Future<List> getData() async {
    final response = await http
        .get(Uri.parse('https://mobilebackend.onrender.com/api/users'));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    }
    return data;
  }

  List _foundUsers = data;

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) async {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      await (10);
      results = data;
    } else {
      results = data
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 7, 97, 171),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoritePage()));
          },
          child: const Icon(Icons.favorite)),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 97, 171),
        title: const Text("House Keeper"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                        labelText: 'Search', suffixIcon: Icon(Icons.search)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount:
                          _foundUsers.length == 0 ? 0 : _foundUsers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                "https://www.pngitem.com/pimgs/m/111-1114839_circle-people-icon-flat-png-avatar-icon-transparent.png",
                              ),
                            ),
                            title: Text(_foundUsers[index]["name"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(_foundUsers[index]["location"]),
                                SizedBox(
                                    height:
                                        10), // Add some spacing between the sub titles
                                Text(_foundUsers[index]["phoneNumber"]),
                                SizedBox(
                                    height:
                                        10), // Add some spacing between the sub titles
                                Text(_foundUsers[index]["age"]),
                                SizedBox(height: 10),
                                Visibility(
                                  visible: _foundUsers[index]["rate"] == 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "New",
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _foundUsers[index]["rate"] != 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "${_foundUsers[index]["rate"]}",
                                              style: TextStyle(
                                                  color: Colors.blueAccent),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.blueAccent,
                                                size: 15)
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
                                  onPressed: () {
                                    AddFav(context, _foundUsers[index]["id"]);
                                  },
                                  icon: Fav.contains(_foundUsers[index]["id"])
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
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
                      }),
                ),
              ],
            );
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
