import 'package:flutter/material.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:Scaffold(
        appBar: AppBar(title: Text('Phone Verification liveasy'),backgroundColor: Colors.blue,),
        body:

        FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot1) {
            // Check for errors
            if (snapshot1.hasError) {
              return null;
            }

            // Once complete, show your application
            if (snapshot1.connectionState == ConnectionState.done) {
              return handleAuth();
            }
            return Container();

          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

