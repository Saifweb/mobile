import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Profil.dart';

List data = [];
List User = [];
ApproveApp(appointments_Id) async {
  var url = "https://mobilebackend.onrender.com/api/reservation/approve";
  url = url + "/" + appointments_Id;
  print(url);
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print("yesss it worked !");
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

RejectApp(appointments_Id) async {
  var url = "https://mobilebackend.onrender.com/api/reservation/reject";
  url = url + "/" + appointments_Id;
  print(url);
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print("yesss it worked !");
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

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  Future<List> getData() async {
    final response = await http
        .get(Uri.parse('https://mobilebackend.onrender.com/api/reservations'));
    data = json.decode(response.body);
    return data;
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
            title: Text('Customer !'),
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
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('ouh ya !');
    }
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
                              //card content
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
                              Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Start date",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 70.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(data[index]["start_date"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 90.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("End Time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 110.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(data[index]["end_date"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )),
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(top: 120.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text("Customer :",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: IconButton(
                                            icon: Icon(Icons.person),
                                            onPressed: () {
                                              getUser(
                                                  data[index]["customer_id"]);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              //buttons
                              Padding(
                                padding: const EdgeInsets.only(top: 150.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Visibility(
                                      visible:
                                          (data[index]["state"] == "pending"),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: FlatButton(
                                          onPressed: () {
                                            ApproveApp(data[index]["id"]);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Appointments Approved !'),
                                                  content: Text(
                                                    "Thanks for Trusting Us !",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Appointments()));
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Accept',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Color.fromRGBO(0, 0, 128, 1),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          data[index]["state"] == "pending",
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: FlatButton(
                                          onPressed: () {
                                            RejectApp(data[index]["id"]);
                                          },
                                          child: Text(
                                            'Reject',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          data[index]["state"] == "approved",
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            data[index]["state"],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          data[index]["state"] == "rejected",
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Text(
                                            data[index]["state"],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.red,
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
