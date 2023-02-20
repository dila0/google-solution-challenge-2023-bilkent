import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

class MomScreen extends StatefulWidget{
  static const String id = 'Mom Screen';
  @override
  _MomScreenState createState() => _MomScreenState();
}

class _MomScreenState extends State<MomScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          //top left corner circles
          Circles(),
          Text('mom screen'),
        ],
      ),
    );
  }
}