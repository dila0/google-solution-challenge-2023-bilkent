import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';

class DadScreen extends StatefulWidget{
  static const String id = 'Dad Screen';
  @override
  _DadScreenState createState() => _DadScreenState();
}

class _DadScreenState extends State<DadScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          //top left corner circles
          Circles(),
          Text('dad screen'),
        ],
      ),
    );
  }
}