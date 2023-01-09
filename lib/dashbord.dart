import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:mobile_project/Profil.dart';
import 'SearchPage.dart';
import 'getpage.dart';


class Dashbord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(0, 0, 128, 1),
          onPressed: () {},
          child: const Icon(Icons.add)
      ),
        body:SafeArea(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu ,color: Color.fromRGBO(0, 0, 128, 1),size:50.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        'assets/profil.png',
                        width: 50.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding:const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Welcome Back Saif !",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(30.0),
                child: Text(
                  "Please select a service !",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 102, 1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding:const EdgeInsets.only(top:40),
                child: Center(
                  child:Wrap(
                    spacing:20.0,
                    runSpacing: 20.0,
                    children: [
                      MaterialButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                          },
                        child:SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child:Card(
                                elevation: 8.0,
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/house.png",width:80.0),
                                          SizedBox(height: 16.0),
                                          Text("House Cleaning",style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),

                                        ],
                                      ),
                                    )

                                )
                            )
                        ),
                      ),
                      MaterialButton(
                          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                          },
                          child:SizedBox(
                          width: 160.0,
                          height: 160.0,
                          child:Card(
                              elevation: 8.0,
                              shape:RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              child:Center(
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Image.asset("assets/office.png",width:100.0),
                                        SizedBox(height: 16.0),
                                        Text("Office Cleaning",style: TextStyle(
                                          color:Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        )),

                                      ],
                                    ),
                                  )

                              )
                          )
                      ),
              ),
                      MaterialButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                        },
                        child:SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child:Card(
                                elevation: 8.0,
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                child:Center(
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/after.png",width:85.0),
                                          SizedBox(height: 16.0),
                                          Text("After Renovation",style: TextStyle(
                                            color:Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),

                                        ],
                                      ),
                                    )

                                )
                            )
                        ),
                      ),
                      MaterialButton(
                          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UsersScreen()));
                          },
                          child:SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child:Card(
                                  elevation: 8.0,
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  child:Center(
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset("assets/eventclean.png",width:80.0),
                                            SizedBox(height: 16.0),
                                            Text("After Event",style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            )),

                                          ],
                                        ),
                                      )

                                  )
                              )
                          ),

                      ),
                    ],
                  )
                ),
              )
            ],
          ),
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
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Appointments() ));
                        },
                      ),
                      IconButton(
                        icon:Icon(Icons.person),
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage() ));},
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