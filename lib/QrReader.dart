import 'package:flutter/material.dart';
import 'package:mobile_project/History.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:http/http.dart' as http;

var k = 0;

DoneApp(appointments_Id) async {
  k++;
  var url = "https://mobilebackend.onrender.com/api/reservation/done";

  url = url + "/" + appointments_Id;

  print(url);

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("yesss it worked !");

      print(response.body);

      // If the server did return a 200 OK response,

    } else {
      throw Exception('${response.body}');
    }
  } catch (er) {
    throw Exception(er);
  }
}

class QRPage extends StatefulWidget {
  const QRPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() async {
        result = event;
        if (result != null && k < 1) {
          await DoneApp(result!.code);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => History()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              width: 400,
              child: QRView(key: _gLobalkey, onQRViewCreated: qr),
            ),
            Center(
              child: (result != null)
                  ? Text('Appointemend Done !')
                  : Text('Scan a code'),
            )
          ],
        ),
      ),
    );
  }
}
