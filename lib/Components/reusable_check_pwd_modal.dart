import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants.dart';
import 'my_buttons.dart';

class CheckPasswordModal extends StatelessWidget {
  final TextEditingController controller;
  final Function buttonAction;
  final Widget optionalWidget;
  final String title;
  final String buttonText;

  const CheckPasswordModal({
    Key? key,
    required this.controller,
    required this.buttonAction,
    this.optionalWidget = const SizedBox.shrink(),
    this.title = 'Enter password to continue',
    this.buttonText = 'Pay',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0b0c18),
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
                obscureText: true,
                cursorColor: componentColor,
                cursorWidth: 3.0,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: componentColor, width: 5),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: componentColor, width: 2),
                  ),
                ),
              ),
            ),
            CustomButton(
              buttonText: buttonText,
              action: () {
                buttonAction();
              },
              width: 50,
              height: 40,
            ),
            optionalWidget,
          ],
        ),
      ),
    );
  }
}
