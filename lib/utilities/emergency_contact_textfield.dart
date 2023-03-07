import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/utilities/firebase_utility.dart';
import 'constants.dart';

class EmergencyContactTextField extends StatefulWidget {
  EmergencyContactTextField(
      {super.key,
      required this.iconName,
      required this.startNumber,
      required this.index,
      required this.deleteFunction,
      this.isLast = false});

  IconData iconName;
  String startNumber;
  final bool isLast;
  final int index;
  final Function deleteFunction;

  @override
  State<EmergencyContactTextField> createState() =>
      _EmergencyContactTextFieldState();
}

class _EmergencyContactTextFieldState extends State<EmergencyContactTextField> {
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    void finished({required String input}) {
      if (input != "" && input != widget.startNumber) {
        FirebaseUtility.addContact(input, widget.startNumber);
        setState(() {
          widget.startNumber = input;
        });
      }
    }

    void delete(String input) {
      widget.deleteFunction(widget.index);
      if (input != "") {
        FirebaseUtility.removeContact(widget.startNumber);
      }
    }

    TextEditingController _controller =
        TextEditingController(text: widget.startNumber);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kButtonRoundness)),
        color: Colors.white60,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Visibility(
                  visible: _isEnable,
                  child: TextField(
                    autofocus: true,
                    /*onTapOutside: (var a) {
                      setState(() {
                        _controller.text = widget.startNumber;
                        _isEnable = false;
                      });
                    },*/
                    onSubmitted: (s) {
                      setState(() {
                        _isEnable = false;
                        finished(input: s);
                      });
                    },
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.phone,
                    textInputAction: widget.isLast
                        ? TextInputAction.done
                        : TextInputAction.next,
                    controller: _controller,
                    enabled: _isEnable,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Visibility(
                  visible: !_isEnable,
                  child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    autofocus: false,
                    /*onTapOutside: (var a) {
                  setState(() {
                    _controller.text = widget.startNumber;
                    _isEnable = false;
                  });
                },*/
                    onSubmitted: (s) {
                      setState(() {
                        _isEnable = false;
                        finished(input: s);
                      });
                    },
                    style: kSignUpTextFieldTextStyle,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.phone,
                    textInputAction: widget.isLast
                        ? TextInputAction.done
                        : TextInputAction.next,
                    controller: _controller,
                    enabled: _isEnable,
                  ),
                ),
              ),
            ],
          ),

          Visibility(
            visible: !_isEnable,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isEnable = true;
                  });
                },
                icon: Icon(widget.iconName),
                iconSize: kBottomIconSize,
                color: kCirclesColor,
              ),
            ),
          ),
          Visibility(
            visible: !_isEnable,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    delete(_controller.text);
                  });
                },
                icon: const Icon(Icons.delete_rounded),
                iconSize: kBottomIconSize,
                color: kCirclesColor,
              ),
            ),
          ),
          Visibility(
            visible: _isEnable,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 5.0, right: 8.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isEnable = false;
                    finished(input: _controller.text);
                  });
                },
                icon: const Icon(Icons.done),
                iconSize: kBottomIconSize,
                color: kCirclesColor,
              ),
            ),
          ),
          //TODO: Take username
        ],
      ),
    );
  }
}
