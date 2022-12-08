import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';

class SearchPage extends StatelessWidget {
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
        title: const Text("House Keeper"),
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
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                colors: [Colors.blue,Color.fromRGBO(0, 0, 150, 1)],
                                begin:Alignment.topLeft,
                                end:Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 12,
                                  offset: Offset(0,6),
                                )
                              ]


                          ),
                        ),
                        Positioned.fill(
                          child:Row(
                            children: <Widget>[
                              Expanded(
                                child:Padding(
                                  padding: const EdgeInsets.only(left: 10,right:10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                      'assets/person.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                flex:2,
                              ),
                              Expanded(
                                flex:4,
                                child:Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          "Akram dhouib",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "House Cleaner",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on,color:Colors.white,size:16),
                                        Text(
                                          " Tunis,hay el ghazela",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child:Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      "4.7",
                                      style:TextStyle(
                                        color:Colors.white,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: List.generate(4, (index) {
                                        return Icon(Icons.star,color: Colors.white);
                                      }
                                      ),
                                    ),



                                  ],
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
