import 'package:flutter/material.dart';
import 'package:mobile_project/WidgetsAndComposents/styles.dart';
import 'package:mobile_project/WidgetsAndComposents/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as global;
import 'package:intl/intl.dart';

final firestore = FirebaseFirestore.instance;

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var roomId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 7, 97, 171),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 97, 171),
        title: const Text('John Do'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: StreamBuilder(
                  stream: firestore.collection('Rooms').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot?> allData = snapshot
                            .data!.docs
                            .where((element) =>
                                element['users'].contains(global.chatUserId) &&
                                element['users']
                                    .contains(global.User[0]["user"]["uid"]))
                            .toList();
                        QueryDocumentSnapshot? data =
                            allData.isNotEmpty ? allData.first : null;
                        if (data != null) {
                          print(data.id);
                          roomId = data.id;
                        }
                        return data == null
                            ? Container()
                            : StreamBuilder(
                                stream: data.reference
                                    .collection('messages')
                                    .orderBy("datatime", descending: true)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? Container()
                                      : ListView.builder(
                                          itemCount: snap.data!.docs.length,
                                          reverse: true,
                                          itemBuilder: (context, i) {
                                            return ChatWidgets.messagesCard(
                                                snap.data!.docs[i]['sent_by'] ==
                                                    global.User[0]["user"]
                                                        ["uid"],
                                                snap.data!.docs[i]['message'],
                                                '');
                                          },
                                        );
                                });
                      } else {
                        return Center(
                          child: Text(
                            'No conversion found',
                            style: Styles.h1().copyWith(
                                color: Color.fromARGB(255, 69, 92, 225)),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    }
                  }),
            ),
          ),
          Container(
            color: Colors.white,
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (roomId != null) {
                Map<String, dynamic> data = {
                  'message': controller.text.trim(),
                  'sent_by': global.User[0]["user"]["uid"],
                  'datatime': DateTime.now(),
                };
                firestore
                    .collection('Rooms')
                    .doc(roomId)
                    .collection("messages")
                    .add(data);
              } else {
                Map<String, dynamic> data = {
                  'message': controller.text.trim(),
                  'sent_by': global.User[0]["user"]["uid"],
                  'datatime': DateTime.now(),
                };
                firestore.collection('Rooms').add({
                  'users': [global.chatUserId, global.User[0]["user"]["uid"]],
                }).then(
                  (value) async {
                    value.collection('messages').add(data);
                  },
                );
              }
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
