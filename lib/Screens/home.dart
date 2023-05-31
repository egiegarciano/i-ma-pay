import 'package:flutter/material.dart';
import 'package:money_transfer_app/Components/my_buttons.dart';
import 'package:money_transfer_app/Screens/login_screen.dart';
import 'package:money_transfer_app/Screens/register_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'K Ma Pay',
                  textStyle: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.w800),
                  speed: const Duration(milliseconds: 300),
                ),
              ],
            ),
            CustomButton(
                buttonText: 'Login',
                action: () {
                  Navigator.pushNamed(context, LoginScreen.loginScreenRoute);
                }),
            const SizedBox(height: 5),
            CustomButton(
                buttonText: 'Register',
                action: () {
                  Navigator.pushNamed(
                      context, RegisterScreen.registerScreenRoute);
                }),
          ],
        ),
      ),
    );
  }
}
