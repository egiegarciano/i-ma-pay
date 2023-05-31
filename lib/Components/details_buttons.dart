import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants.dart';

class DetailsButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonAction;
  final IconData icon;
  const DetailsButton({
    Key? key,
    required this.buttonText,
    required this.buttonAction,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: buttonAction,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(componentColor),
            minimumSize: MaterialStateProperty.all(const Size(60, 60)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: Icon(
            icon,
            size: 30.0,
            color: textColor,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          buttonText,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
