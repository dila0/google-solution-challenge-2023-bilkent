import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../utilities/firebase_utility.dart';
import '../utilities/register_text_field.dart';

class infoPage extends StatelessWidget {
  String? contact;
  infoPage(String contactName){
    if (contactName == "MOM") this.contact = "mother";
    else if (contactName == "DAD") this.contact = "father";
    else if (contactName == "LOVER") this.contact = "boyfriend";
    else if (contactName == "BESTIE") this.contact = "friend";
    else this.contact = "selected contact";
  }






  @override
  Widget build(BuildContext context) {

    String howToUseCallFunction = "When you press \'Start Call\' button that appears when you select a contact, your phone will ring. We carefully recorded various prompts to simulate a comfortable phone call. All you need to do is to answer the questions and pretend that you are having a real phone call with your $contact. ";

    String whatIsTheSafeWord = "If the trigger word detection is enabled in the settings and if you selected your emergency contacts from the profile screen, you have the opportunity to inform your contacts when you use the word \"AMERICANO\" as you speak with your $contact. If you say americano we will send a text message with your current location.";

    String itWillVibrate = "When you say the safe word and when your contacts are informed of your location, your phone will vibrate to indicate that the operation is successful.";

    String safeWordDisabled = "The safe word detection feature is experimental and we cannot offer it to the market yet due to the monetary restrictions. However if your \"Trigger Word Detection\" is close, there will be a button in your screen that does the exact operations as described above!";

    String fakeUI = "The buttons in the call page when you answer the call from your $contact, are there just make it look like you're having an actual phone call. So make sure you do no try to engage with them :)";

    void clickedDone() {
        Navigator.pop(context);
      }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Information Page",
          style: kEmergencyContactTextStyle.copyWith(color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kButtonColor,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 100,
              width: double.infinity,
            ),
            InfoSection(context, "1. How to use the call function", howToUseCallFunction),
            InfoSection(context, "2. What is the safe word?", whatIsTheSafeWord),
            InfoSection(context, " 3.  How can I understand if the app understood the safe word?" , itWillVibrate),
            InfoSection(context, " 4. What will happen if I don't enable Safe Word Detection?" , safeWordDisabled),
            InfoSection(context, " 5. Why can't I use the buttons in the phone screen?" , fakeUI),
            SizedBox(height: MediaQuery.of(context).size.height / 25,
              width: double.infinity,)
          
          ],
        ),
      ),
    );
  }
}

Column InfoSection(BuildContext context, String title, String text){
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/90,left:MediaQuery.of(context).size.width/14, right: MediaQuery.of(context).size.width/14 ),
        child: Text(title, style: kInfoTileStyle, textAlign: TextAlign.center,),
      ),
      Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/150, horizontal: MediaQuery.of(context).size.width/14 ) ,
          child: Text(text, style: kInfoTextStyle, textAlign: TextAlign.justify,))
    ],
  );

}