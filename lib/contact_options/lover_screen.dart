import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

class LoverScreen extends StatefulWidget{
  static const String id = 'Lover Screen';
  @override
  _LoverScreenState createState() => _LoverScreenState();
}

class _LoverScreenState extends State<LoverScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          //top left corner circles
          Circles(),
          Text('lover screen'),
        ],
      ),
    );
  }
}