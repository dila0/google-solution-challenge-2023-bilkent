import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_solution/screens/change_name_screen.dart';
import 'package:google_solution/screens/change_password_screen.dart';
import 'package:google_solution/utilities/constants.dart';
import 'package:google_solution/utilities/circles.dart';
import 'package:google_solution/utilities/bottom_bar.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:google_solution/utilities/custom_animations.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_alert_dialog/models/alert_dialog_style.dart';
import 'package:smart_alert_dialog/models/alert_dialog_text.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:flutter/src/material/material.dart';
import '../utilities/profile_container.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'Settings Screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool triggerWordDetection = false;
  bool toDelete = false;
  SharedPreferences prefs = FirebaseUtility.prefs;

  void _yesNoSmartAlert(BuildContext context, String message, String text, String action) {


       // onConfirmPressed:() => FirebaseUtility.deleteAccount(context)
       var alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: Colors.grey[100],
      elevation: 0.0,
      content:  Container(
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 15),
                      child: Text(message,
                        style: TextStyle(
                            color: kCallContainerColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  Text(text,
                    style: kWarningTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context, 'OK');

                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: kButtonColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                  child: Text(
                                    'CANCEL',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),

                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child:  InkWell(
                            onTap: () {
                              Navigator.pop(context, 'OK');
                              if(action == "delete")
                              FirebaseUtility.deleteAccount(context);
                              else{
                                FirebaseUtility.logout(context);
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: kButtonColor),
                              child: const Center(
                                child: Text(
                                  'OKAY',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),

                      )
                    ],
                  ),
                ],
              ),
              ),
            );
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext c){
                return alert;}
            );
  }




  void getPreferences() {

    setState(() {
      if(prefs == null){
        triggerWordDetection = false;
        return;
      }
      triggerWordDetection = prefs.getBool('triggerWord') ?? false;
    });
  }

  void changeTriggerWordDetectionStatus() async {
    triggerWordDetection = !triggerWordDetection;
    await prefs.setBool('triggerWord', triggerWordDetection);
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreferences();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: SliverAppBar(
              stretch: true,
              title: const Circles(),
              backgroundColor: kBackgroundColor,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height / 4,
              centerTitle: false,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SettingsGroup(
                settingsGroupTitle: "Preferences",
                settingsGroupTitleStyle:
                    kSignUpInfoStyle.copyWith(fontWeight: FontWeight.w900),
                items: [
                  SettingsItem(
                    onTap: () {
                      setState(() {
                        changeTriggerWordDetectionStatus();
                      });
                    },
                    icons: Icons.mic,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.black54,
                    ),
                    title: 'Trigger Word Detection',
                    subtitle: "Experimental!",
                    trailing: Switch.adaptive(
                      value: triggerWordDetection,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitleStyle:
                    kSignUpInfoStyle.copyWith(fontWeight: FontWeight.w900),
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    title: "Change name",
                    icons: Icons.person_2_sharp,
                    iconStyle: IconStyle(),
                    titleStyle: kSignUpInfoStyle,
                    onTap: () => Navigator.push(
                        context,
                        CustomAnimations.slideTransition(
                          page: ChangeName(),
                        )),
                  ),
                  SettingsItem(
                    icons: Icons.password_rounded,
                    title: "Change password",
                    iconStyle: IconStyle(backgroundColor: Colors.teal),
                    titleStyle: kSignUpInfoStyle,
                    onTap: () => Navigator.push(
                        context,
                        CustomAnimations.slideTransition(
                          page: ChangePassword(),
                        )),
                  ),
                  SettingsItem(
                    onTap: () {
                      _yesNoSmartAlert(context,'You are about to sign out!'," Are you sure you would like to log out from your account?", "logout");
                    },
                    icons: Icons.exit_to_app_rounded,
                    iconStyle: IconStyle(backgroundColor: Colors.amber),
                    title: "Sign out",
                    titleStyle: kSignUpInfoStyle,
                  ),
                  SettingsItem(
                      onTap: () {
                        _yesNoSmartAlert(context,'Are you sure you would like to delete your account?',"This action cannot be undone!", "delete");

                      },
                      icons: Icons.delete_forever,
                      iconStyle: IconStyle(backgroundColor: Colors.red),
                      title: "Delete account",
                      titleStyle: kSignUpInfoStyle.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ],
              ),
              SettingsGroup(
                settingsGroupTitleStyle:
                    kSignUpInfoStyle.copyWith(fontWeight: FontWeight.w900),
                settingsGroupTitle: "Information",
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.share_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.lightGreen,
                    ),
                    title: 'Share',
                    subtitle: "Share our App with your friends <3",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'About',
                    subtitle: "Learn more about our App",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.insert_drive_file_outlined,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.blueGrey,
                    ),
                    title: 'KVKK',
                    subtitle: "Read KVKK",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}
