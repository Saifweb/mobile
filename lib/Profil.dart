import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.add)
      ),
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Color.fromRGBO(0, 0, 128, 1)]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(
                            'assets/women.jpg',
                            width: 100.0,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Alice James",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top:25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    onPressed: () {},
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color:Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 128, 1),
                              blurRadius: 12,
                              offset: Offset(0,2),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.done,color:Color.fromRGBO(0, 0, 128, 1),size:30)
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "50 ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )

                ),
                MaterialButton(
                    onPressed: () {},
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color:Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 128, 1),
                              blurRadius: 12,
                              offset: Offset(0,2),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.star,color:Color.fromRGBO(0, 0, 128, 1),size:30)
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    )

                ),
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //this padding to fixe the distance
                Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: Container(
                    width:350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color:Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 128, 1),
                            blurRadius: 12,
                            offset: Offset(0,2),
                          )
                        ]
                    ),

                    child: MaterialButton(
                        onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.history,color:Color.fromRGBO(0, 0, 128, 1),size:30)
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "Purchase History",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),

                    ),
                  ),
                ),
                Container(
                  width:350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 128, 1),
                          blurRadius: 12,
                          offset: Offset(0,2),
                        )
                      ]
                  ),

                  child: MaterialButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.settings,color:Color.fromRGBO(0, 0, 128, 1),size:30)
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                  ),
                ),
              ],

            ),
          )
        ],
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
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentsPage() ));
                        },
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