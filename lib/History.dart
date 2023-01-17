import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Profil.dart';
import 'package:mobile_project/dashbord.dart';
import 'package:mobile_project/updatemail.dart';
import 'package:mobile_project/updatepass.dart';

List data = [];
List User = [];
var Ourresarvationid;

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<List> getData() async {
    final response = await http.get(
        Uri.parse('https://mobilebackend.onrender.com/api/reservations_done'));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
    }
    return data;
  }

  GiveRate(reservation_Id, rate) async {
    var url = "https://mobilebackend.onrender.com/api/giverate";
    url = url + "/" + reservation_Id;
    print(url);
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, double>{
          'rate': rate,
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
        // If the server did return a 200 OK response,
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('${response.body}');
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  getUser(User_id) async {
    var url = "https://mobilebackend.onrender.com/api/user";
    url = url + "/" + User_id;
    final response = await http.get(Uri.parse(url));
    User = [json.decode(response.body)];
    if (response.statusCode == 200) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('House Keeper !'),
            content: Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(1.0), child: Text("name: ")),
                Padding(
                    padding: const EdgeInsets.only(left: 50, top: 1.0),
                    child: Text(User[0]["name"])),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text("location: ")),
                Padding(
                    padding: const EdgeInsets.only(left: 70, top: 20.0),
                    child: Text(User[0]["location"])),
                Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text("phoneNumber: ")),
                Padding(
                    padding: const EdgeInsets.only(left: 120, top: 40.0),
                    child: Text(User[0]["phoneNumber"])),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {}
  }

  @override
  var rating;
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 7, 97, 171),
          onPressed: () {},
          child: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 97, 171),
        title: Text("Previous Work"),
        centerTitle: true,
        actions: [],
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
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 128, 1),
                                          blurRadius: 12,
                                          offset: Offset(0, 2),
                                        )
                                      ]),
                                ),

                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_box,
                                        color: Color.fromARGB(255, 7, 97, 171),
                                      ),
                                      tooltip: 'add feedback',
                                      onPressed: () {
                                        Ourresarvationid = data[index]["id"];
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('FeedBack'),
                                              content: RatingBar.builder(
                                                  minRating: 1,
                                                  itemSize: 46,
                                                  itemBuilder: (context, _) =>
                                                      Icon(Icons.star,
                                                          color: Colors.blue),
                                                  updateOnDrag: true,
                                                  onRatingUpdate: (rating) =>
                                                      setState(() {
                                                        this.rating = rating;
                                                      })),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Ok'),
                                                  onPressed: () {
                                                    GiveRate(data[index]["id"],
                                                        this.rating);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                //card content
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 1, left: 350),
                                  child: IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: () {
                                      print(data[index]["housekeeper_id"]);
                                      getUser(data[index]["housekeeper_id"]);
                                    },
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(data[index]["type"],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18)),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 70.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "Location : ${data[index]["location"]}   || ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              )),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 70.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "Price: ${data[index]["price"]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              )),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 110.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "${data[index]["start_date"]}-",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              )),
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(top: 110.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(data[index]["end_date"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              )),
                                        )),
                                  ],
                                ),

                                //buttons

                                Padding(
                                  padding: const EdgeInsets.only(top: 140.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 5),
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Done !',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )));
                  });
            }
          }),
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
