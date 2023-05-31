import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMsg;
  final String optionalTitle;
  final Function(BuildContext context) action;

  const ErrorDialog(
    this.errorMsg,
    this.action, {
    Key? key,
    this.optionalTitle = 'Error',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: mainColor,
      title: Text(
        optionalTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
      content: Text(errorMsg),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Okay',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            action(context);
          },
        ),
      ],
    );
  }
}
