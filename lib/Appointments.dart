import 'package:flutter/material.dart';

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.add)
      ),
      appBar:AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 128, 1),
        title: const Text("My Appointments"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body:ListView.builder(
          padding: EdgeInsets.only(top: 40,bottom:60),
          itemCount: 4,
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
                                "House Cleaning",
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
                                  "Schedule date",
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
                                  "15/5/2000",
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
                                  "Schedule Time",
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
                                  "20:00",
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
                            padding: const EdgeInsets.only(top:130.0),
                            child: Align(
                              alignment: Alignment.center,
                              child:Text(
                                  "Client:  MR X ",
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
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Color.fromRGBO(0, 0, 128, 1),
          child: IconTheme(
              data:IconThemeData(color:Theme.of(context).colorScheme.onSecondary),
              child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      IconButton(
                        icon:Icon(Icons.home),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon:Icon(Icons.list),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon:Icon(Icons.person),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon:Icon(Icons.settings),
                        onPressed: (){},
                      ),
                    ],
                  )
              )
          )
      ),

    );
  }
}
