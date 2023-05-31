import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback action;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.action,
    this.width = double.infinity,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(componentColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(width, height),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
