import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
List data=[];
AcceptApp(){

}
class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    Future <List> getData() async {
      final response = await http.get( Uri.parse('https://mobilebackend.onrender.com/api/reservations'));
      data=json.decode(response.body);
      return data;
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.add)
      ),
      appBar:AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
        title: const Text("House Keeper"),
        actions: [
          IconButton(onPressed: () {
          }, icon: const Icon(Icons.search))
        ],
      ),
      body:FutureBuilder<List<dynamic>>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.data==null){
            return Center(child: const CircularProgressIndicator(), );
          }
          else{
            return ListView.builder(
                padding: EdgeInsets.only(top: 40,bottom:60),
                itemCount: data.length == 0 ? 0: data.length,
                itemBuilder:(context,index){
                  return   Center(
                      child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:Stack(
                            children: <Widget>[
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 128, 1),
                                        blurRadius: 12,
                                        offset: Offset(0,2),
                                      )
                                    ]
                                ),
                              ),
                              //card content
                              Padding(
                                  padding: const EdgeInsets.only(top:25.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        data[index]["type"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top:50.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        "Start date",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top:70.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        data[index]["start_date"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top:90.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        "End Time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top:110.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        data[index]["end_date"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top:130.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:Text(
                                        data[index]["customer_id"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        )
                                    ),
                                  )
                              ),
                              //buttons
                              Padding(
                                padding: const EdgeInsets.only(top:150.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right:5),
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Accept',
                                          style:TextStyle(color:Colors.white),
                                        ),
                                        color: Color.fromRGBO(0, 0, 128, 1),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:5),
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Reject',
                                          style:TextStyle(color:Colors.white),
                                        ),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),







                            ],
                          )

                      )
                  );
                }
            );
          }
        },

      ),

    );
  }
}
