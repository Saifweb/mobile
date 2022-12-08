import 'package:flutter/material.dart';
import 'package:mobile_project/SearchPage.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),


        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo.png")
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:40),
                  child: Column(
                    children: <Widget>[
                      inputFile(label: "Full Name"),
                      inputFile(label: "Email"),
                      inputFile(label: "State"),
                      inputFile(label: "Password", obscureText: true),
                      inputFile(label: "Confirm Password", obscureText: true),

                    ],
                  ),
                ),

                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: Color(0xff0054FF),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage() ));

                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:Color(0xff0054FF),
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          )

                      ),
                    ),
                  ),
                ),



              ],
            ))
          ],
        ),
      ),
    );
  }

}


// we will be creating a widget for text field
Widget inputFile({label, obscureText = false,})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,

      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(

            filled:true,
            contentPadding: EdgeInsets.symmetric(vertical: 0,
                horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(50),
            )
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}