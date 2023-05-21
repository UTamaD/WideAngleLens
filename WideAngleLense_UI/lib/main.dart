import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wide Angle Detect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wide Angle Detect'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var image = null;
  var loading = false;
  late List<dynamic> _output;


  @override
  void initState() {
    // TODO: implement initState
  }

  Future<void> analyzeImage() async {
  }

  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 10.0,
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('Wide Angle Lens',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1, fontWeight: FontWeight.bold),
                        ),
                        Text('checker',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.grey,
                    child: image != null
                        ? Image.file(File(image.path))
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                "Place Image",
                                style: TextStyle(color: Colors.white, fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  image != null
                      ? loading ? Text('normal Lens', style: TextStyle(fontSize: 40, color: Colors.green)) :
                      Text('Analyzing...', style: TextStyle(fontSize: 40, color: Color.fromRGBO(118, 12, 12, 1)) ,)
                      : const SizedBox(
                          height: 20,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextButton(
                      onPressed: () async {
                        var picker = ImagePicker();
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                            print(image.path);
                        await analyzeImage();
                        if (image != null) {
                          setState(() {loading = false;});
                          Timer(Duration(seconds: 2), () => { 
                            setState(() {
                              loading = true;
                            })
                          });
                        }
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        color: Colors.black45,),
                        padding: EdgeInsets.all(10.0),
                        child: const Text(
                          'Choose Image',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ))
                ],
              ),
            ]));
  }
}
