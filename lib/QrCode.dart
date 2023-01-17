import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import './globals.dart' as global;

void main() {
  runApp(const MyQR());
}

class MyQR extends StatelessWidget {
  const MyQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String data = global
      .reservation_id; //  here we insert the project ID in the QR image to be received by the scanner
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
