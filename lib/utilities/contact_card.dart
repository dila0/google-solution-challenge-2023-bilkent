import 'package:flutter/material.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../models/callerData.dart';
import '../screens/incoming_call_screen.dart';
import 'constants.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:google_solution/contact_options/dad_screen.dart';
import 'package:provider/provider.dart';

class ContactCard extends StatefulWidget {
  ContactCard(
      {required this.contactName,
      this.imageUrl,
      this.utilitiesText,
      this.durationText,
      required this.page});
  final String contactName;
  final String? imageUrl;
  final String? utilitiesText;
  final String? durationText;
  final Widget page;
  @override
  State<ContactCard> createState() =>
      _ContactCard(contactName, imageUrl, utilitiesText, durationText, page);
}

class _ContactCard extends State<ContactCard> {

  _ContactCard(this.contactName, this.imageUrl, this.utilitiesText,
      this.durationText, this.page);
  final String contactName;
  final String? imageUrl;
  final String? utilitiesText;
  final String? durationText;
  final Widget page;
  bool fav = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {

    double deviceWidth =  MediaQuery.of(context).size.width;
    print("Width = $deviceWidth");
    if (FirebaseUtility.favourites.contains(contactName)) {
      fav = true;
    }

    return GestureDetector(
      onTap: () {
        print('$selected');
        //Navigator.pushNamed(context, routeName);
        setState(() {
          selected = !selected;
        });
        Provider.of<callerData>(context, listen: false)
            .setCallerName(contactName ?? '');
      },
      child: Card(
        color: kContactColor,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width:(deviceWidth < 400) ? 100 : 330.0,
          height: selected ? 160.0 : 130.0,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 7.0),
              Text(
                contactName!,
                style: kContactNameTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //const SizedBox(width: 10.0),
                  Image.asset(
                    imageUrl ?? '',
                    height: 60.0,
                    width: 60.0,
                  ),
                  //const SizedBox(width: 15.0),
                  SizedBox(
                    width: 200.0,
                    child: Text(
                      utilitiesText ?? '',
                      style: kContactUtilitiesTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //const SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 12.0),
                      Text(
                        durationText ?? '',
                        style: kContactDurationTextStyle,
                      ),
                      FavoriteButton(
                        isFavorite: fav,
                        iconSize: 45.0,
                        iconDisabledColor: kBackgroundColor,
                        iconColor: kButtonColor,
                        valueChanged: (_isFavorite) {
                          //TODO nasıl çalışıyor emin değilim bi bakmak lazım digotto ile -ati
                          if (_isFavorite) {
                            FirebaseUtility.addFavourite(contactName);
                          } else {
                            FirebaseUtility.removeFavourite(contactName);
                          }
                          print('Is Favorite $_isFavorite');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' '),
                  selected == true
                      ? TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, IncomingScreen.id);
                          },
                          child: Text("START CALL"))
                      : Text(''),
                  selected == true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return page;
                            }));
                          },
                          child: Icon(
                            Icons.question_mark_outlined,
                            color: Colors.purpleAccent,
                            size: 15,
                          ),
                        )
                      : Text(''),
                  Text(' ')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
