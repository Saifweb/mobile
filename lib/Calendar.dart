import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_project/Appointments.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_project/Profil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_project/CalendarForm.dart';

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);

final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);


final colblue = Color.fromARGB(255, 7, 97, 171);

final List<String> items = [
  'House Cleaning',
  'Office Cleaning',
  'After Renovation',
  'After Event'
];

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text('Calender'),
          backgroundColor: colblue,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  weekendDays: [6],
                  headerStyle: HeaderStyle(
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    formatButtonVisible: false,
                    decoration: BoxDecoration(
                      color: colblue,
                    ),
                    headerMargin: const EdgeInsets.only(bottom: 10.0),
                    titleTextStyle: TextStyle(color: Colors.white),
                  ),
                  calendarStyle: CalendarStyle(),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;

                      _focusedDay = focusedDay;
                      print(_selectedDay);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarForm(
                            selectedDay: _selectedDay,
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CalendarForm(argument: _selectedDay)));
                    });
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          backgroundColor: colblue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarForm(
                  selectedDay: _selectedDay,
                ),
              ),
            );
          },
        ));
  }
}