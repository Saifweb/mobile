import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PlatformFile? pickedFile ;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result==null)return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white, //<-- SEE HERE
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ( pickedFile != null)
                Expanded(child: Container(
                  color: Colors.blue[100],
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text('Select File'),
                onPressed: selectFile,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text('Upload File'),
                onPressed: uploadFile,
              ),


            ],
          ),

        )
    );
  }

}