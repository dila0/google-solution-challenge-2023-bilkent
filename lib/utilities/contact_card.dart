import 'package:flutter/material.dart';
import '../models/callerData.dart';
import 'constants.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:google_solution/contact_options/dad_screen.dart';
import 'package:provider/provider.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,  required this.contactName, required this.imageUrl,
    required this.utilitiesText, required this.durationText, required this.routeName
  });

  final String contactName;
  final String imageUrl;
  final String utilitiesText;
  final String durationText;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kContactColor,
      child: InkWell(
        splashColor: kButtonColor,
        onTap: (){
          Navigator.pushNamed(context, routeName);
          Provider.of<callerData>(context, listen: false).setCallerName(contactName);
        },
        child: SizedBox(
          width: 330.0,
          height: 130.0,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 7.0),
              Text(
                contactName,
                style: kContactNameTextStyle,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(width: 10.0),
                  Image.asset(imageUrl,
                    height: 60.0,
                    width: 60.0,
                  ),
                  const SizedBox(width: 15.0),
                  SizedBox(
                    width: 200.0,
                    child: Text(utilitiesText,
                      style: kContactUtilitiesTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 12.0),
                      Text(durationText,
                        style: kContactDurationTextStyle,
                      ),
                      FavoriteButton(
                        iconSize: 45.0,
                        iconDisabledColor: kBackgroundColor,
                        iconColor: kButtonColor,
                        valueChanged: (_isFavorite){
                          //TODO: Add the item to saved audio
                          print('Is Favorite $_isFavorite');
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}