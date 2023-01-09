import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Profil.dart';
class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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

        title: Padding(

          padding: const EdgeInsets.fromLTRB(130, 0, 20, 0),

          child: Text("Previous Work",

              textAlign: TextAlign.center,

              style: TextStyle(

                  color: Colors.white,

                  fontWeight: FontWeight.w600,

                  fontSize: 18)),

        ),

        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],

      ),

      body: ListView.builder(

          padding: EdgeInsets.only(top: 40, bottom: 60),

          itemCount: 4,

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

                                color: Color.fromRGBO(0, 0, 128, 1),

                              ),

                              tooltip: 'add feedback',

                              onPressed: () {

                                // Navigator.push(

                                //   context,

                                //   MaterialPageRoute(builder: (context) => SecondRoute()),

                                // );

                              },

                            ),

                          ],

                        ),

                        //card content

                        Padding(

                            padding: const EdgeInsets.only(top: 25.0),

                            child: Align(

                              alignment: Alignment.center,

                              child: Text("House Cleaning",

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

                              child: Text("cleaning date",

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

                              child: Text("15/5/2000",

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

                              child: Text("Location",

                                  textAlign: TextAlign.center,

                                  style: TextStyle(

                                    color: Colors.black45,

                                    fontWeight: FontWeight.w600,

                                    fontSize: 15,

                                  )),

                            )),



                        Padding(

                            padding:

                            const EdgeInsets.only(right: 120, top: 110.0),

                            child: Align(

                              alignment: Alignment.center,

                              child: Row(

                                children: <Widget>[

                                  SizedBox(

                                    width: 120.0,

                                    height: 20.0,

                                  ),

                                  Icon(Icons.location_on,

                                      color: Colors.black, size: 16),

                                  Text(

                                    " Tunis,hay el ghazela",

                                    style: TextStyle(

                                      color: Colors.black,

                                      fontFamily: 'Avenir',

                                      fontWeight: FontWeight.w700,

                                    ),

                                  ),

                                ],

                              ),

                            )),

                        //buttons

                        Padding(

                          padding: const EdgeInsets.only(top: 140.0),

                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[

                              Padding(

                                padding:

                                const EdgeInsets.only(left: 15, right: 5),

                                child: FlatButton(

                                  onPressed: () {},

                                  child: Text(

                                    'Done !',

                                    style: TextStyle(color: Colors.white),

                                  ),

                                  color: Color.fromRGBO(0, 0, 128, 1),

                                ),

                              ),

                            ],

                          ),

                        ),

                      ],

                    )));

          }),

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

                        onPressed: () {},

                      ),

                      IconButton(

                        icon: Icon(Icons.person),

                        onPressed: () {},

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
