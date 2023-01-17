import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './WidgetsAndComposents/styles.dart';
import './WidgetsAndComposents/Widgets.dart';
import './ChatPage.dart';
import 'package:http/http.dart' as http;

import 'globals.dart' as global;

class ChatsHome extends StatefulWidget {
  ChatsHome({Key? key}) : super(key: key);
  @override
  State<ChatsHome> createState() => _ChatsHomeState();
}

List data = [];
var User_id;
final firestore = FirebaseFirestore.instance;
Future<List> getData() async {
  final response =
      await http.get(Uri.parse('https://mobilebackend.onrender.com/api/users'));
  if (response.statusCode == 200) {
    data = json.decode(response.body);
  }
  return data;
}

class _ChatsHomeState extends State<ChatsHome> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Flash Chat'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    open == true ? open = false : open = true;
                  });
                },
                icon: Icon(
                  open == true ? Icons.close_rounded : Icons.search_rounded,
                  size: 30,
                )),
          )
        ],
      ),
      drawer: ChatWidgets.drawer(),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Colors.indigo.shade400,
                    padding: const EdgeInsets.all(8),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            'Recent Users',
                            style: Styles.h1(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return ChatWidgets.circleProfile();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Contacts',
                            style: Styles.h1().copyWith(color: Colors.indigo),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: FutureBuilder(
                                future: getData(),
                                builder: (context, snapshot) {
                                  return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return ChatWidgets.card(
                                          title: data[index]['name'],
                                          time: '04:40',
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const ChatPage(
                                                    id: "13zLtZRs6AZg5573tdJooqr7pqn1",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open)
          ],
        ),
      ),
    );
  }
}
