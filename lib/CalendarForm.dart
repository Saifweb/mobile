import 'dart:convert';
import 'package:mobile_project/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Profil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'globals.dart' as globals;

final colblue = Color.fromARGB(255, 7, 97, 171);

//regular cleaning
final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
var url =
    'https://mobilebackend.onrender.com/api/reservation' + "/" + globals.id;
Future<calenderAppointment> Create_calenderAppointment(
    BuildContext context,
    String price,
    String location,
    String comment,
    String startDate,
    String lastDate) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'location': location,
        'price': price,
        // 'comment': comment,
        'type': globals.type,
        'housekeeper_id': globals.id,
        'start_date': startDate,
        "end_date": lastDate,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return User.fromJson(jsonDecode(response.body));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CalendarPage()));
      return calenderAppointment(
        price: response.body,
        location: response.body,
        comment: response.body,
        startDate: response.body,
        lastDate: response.body,
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('${response.body}');
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return calenderAppointment(
        price: '20',
        location: "",
        comment: "",
        startDate: DateTime.now().toString(),
        lastDate: DateTime.now().toString());
  }
}

class calenderAppointment {
  final String price;
  final String location;
  final String comment;
  final String lastDate;
  final String startDate;

  const calenderAppointment(
      {required this.price,
      required this.location,
      required this.comment,
      required this.startDate,
      required this.lastDate});
  factory calenderAppointment.fromJson(Map<String, dynamic> json) {
    return calenderAppointment(
      lastDate: json['lastDate'],
      startDate: json['startDate'],
      price: json['price'],
      location: json['location'],
      comment: json['comment'],
    );
  }
}

class CalendarForm extends StatefulWidget {
  final DateTime selectedDay;
  CalendarForm({Key? key, required this.selectedDay}) : super(key: key);

  @override
  State<CalendarForm> createState() => _CalendarForm();
}

class _CalendarForm extends State<CalendarForm> {
  final TextEditingController _locationcontroller = TextEditingController();
  final TextEditingController _commentcontroller = TextEditingController();
  String _startDate = '';
  String _lastDate = '';
  double _totalPrice = 0;

  Future<calenderAppointment>? _futurecalenderAppointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.clear, color: colblue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colblue,
                ),
                onPressed: () {
                  if (_locationcontroller.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                            'location required !',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_lastDate.isEmpty || _startDate.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                            'please select a starting and an ending date !',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (_totalPrice == 0.0) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text(
                            'please select a feature !',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    _futurecalenderAppointment = Create_calenderAppointment(
                        context,
                        _totalPrice.toString(),
                        _locationcontroller.text,
                        _commentcontroller.text,
                        _lastDate,
                        _startDate);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appointments()));
                  }
                },
                child: Text('Save'),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          FormBuilder(
            child: Column(children: [
              // FormBuilderTextField(
              //   name: 'name',
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'location is Required';
              //     } else {
              //       return null;
              //     }
              //   },
              //   decoration: InputDecoration(
              //     hintText: 'Client_Name',
              //     prefixIcon: Icon(Icons.arrow_right_outlined),
              //     border: InputBorder.none,
              //   ),
              // ),
              // Divider(),
              FormBuilderTextField(
                name: 'location',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: _locationcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'location is Required';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'House_Location',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.house_sharp),
                ),
              ),
              Divider(),
              // FormBuilderDateTimePicker(
              //   name: 'date',
              //   initialValue: DateTime.now(),
              //   fieldHintText: 'Picked Date',
              //   inputType: InputType.date,
              //   decoration: InputDecoration(
              //       border: InputBorder.none,
              //       prefixIcon: Icon(Icons.calendar_today_sharp)),
              // ),
              FormBuilderDateRangePicker(
                name: 'date_range',
                // controller: _datecontroller,
                firstDate: widget.selectedDay,
                lastDate: DateTime(2024),

                onChanged: (val) {
                  _startDate = val!.start.toString();
                  _lastDate = val.end.toString();
                },
                // initialValue:  PickerDateRange(widget.selectedDay,widget.selectedDay),

                decoration: InputDecoration(
                  labelText: 'Date Range',
                  hintText: 'choose starting and finishing date ',
                  border: InputBorder.none,

                  prefixIcon: Icon(Icons.calendar_today_sharp),
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.close),
                  //   onPressed: () {},
                  // ),
                ),
              ),
              Divider(),

              // FormBuilderDropdown<String>(
              //   // autovalidate: true,
              //   name: 'types',

              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     // prefixIcon: Icon(Icons.arrow_drop_down),
              //     labelText: 'Type Of Cleaning',
              //     hintText: 'Select type',
              //   ),

              //   items: items
              //       .map((gender) => DropdownMenuItem(
              //             alignment: AlignmentDirectional.center,
              //             value: gender,
              //             child: Text(gender),
              //           ))
              //       .toList(),
              //   onChanged: (val) {
              //     setState(() {
              //       // _genderHasError = !(_formKey
              //       //         .currentState?.fields['gender']
              //       //         ?.validate() ??
              //       //     false);
              //     });
              //   },
              //   valueTransformer: (val) => val?.toString(),
              // ),
              FormBuilderCheckboxGroup(
                decoration: InputDecoration(
                  labelText: "Select Features",
                ),
                name: "prices",
                options: [
                  FormBuilderFieldOption(
                      value: 10.0, child: Text("House Cleaning : 20DT")),
                  FormBuilderFieldOption(
                      value: 20.0, child: Text("OutDoors Cleaning : 10DT")),
                  FormBuilderFieldOption(
                      value: 30.0, child: Text("Sheets Washing : 20DT")),
                ],
                onChanged: (val) {
                  double total = 0;
                  for (var price in val!) {
                    total += (price as double);
                  }
                  ;

                  setState(() => _totalPrice = total);
                  // print(_totalPrice);
                },
              ),
              Divider(),
              FormBuilderTextField(
                name: 'Comment',
                controller: _commentcontroller,
                decoration: InputDecoration(
                  hintText: 'Any Additional Comment',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.arrow_right_outlined),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
