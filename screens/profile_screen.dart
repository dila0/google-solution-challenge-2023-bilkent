import 'package:flutter/material.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/bottom_bar.dart';

class ProfileScreen extends StatefulWidget{
  static const String id = 'Profile Screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: const <Widget>[
          Circles(),
          Text('profile screen'),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        color: kBackgroundColor,
        child: BottomBar(),
      ),
    );
  }
}


