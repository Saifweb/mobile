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
  final response = await http
      .get(Uri.parse('https://mobilebackend.onrender.com/api/allusers'));
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
      backgroundColor: Color.fromARGB(255, 7, 97, 171),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 97, 171),
        title: const Text('Welcome to Chat Section !'),
        elevation: 0,
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              'Contacts',
                              style: Styles.h1().copyWith(
                                  color: Color.fromARGB(255, 7, 97, 171)),
                            ),
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
                                          time: '',
                                          onTap: () {
                                            global.chatUserId =
                                                data[index]["id"];
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const ChatPage(
                                                      //id: "13zLtZRs6AZg5573tdJooqr7pqn1",
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
