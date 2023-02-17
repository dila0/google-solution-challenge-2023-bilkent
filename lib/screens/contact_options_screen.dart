import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

class ContactOptionsScreen extends StatefulWidget{
  static const String id = 'Contact Options Screen';
  @override
  _ContactOptionsScreenState createState() => _ContactOptionsScreenState();
}

class _ContactOptionsScreenState extends State<ContactOptionsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
          children: <Widget>[
          //top left corner circles
          Circles(),
          ],
      ),
    );
  }
}