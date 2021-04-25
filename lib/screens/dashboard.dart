import 'package:flutter/material.dart';

import 'package:flutter_app/services/authservice.dart';
class DashboarPage extends StatefulWidget {
  @override
  _DashboarPageState createState() => _DashboarPageState();
}

class _DashboarPageState extends State<DashboarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        child: Text('signout'),
        onPressed: signOut()
      ),
    );
  }
}
