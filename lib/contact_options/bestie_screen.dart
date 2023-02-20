import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

class BestieScreen extends StatefulWidget{
  static const String id = 'Bestie Screen';
  @override
  _BestieScreenState createState() => _BestieScreenState();
}

class _BestieScreenState extends State<BestieScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          //top left corner circles
          Circles(),
          Text('bestie screen'),
        ],
      ),
    );
  }
}