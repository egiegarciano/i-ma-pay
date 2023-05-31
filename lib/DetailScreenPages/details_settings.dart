import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_transfer_app/DetailScreenPages/SettingScreens/change_password.dart';
import 'package:money_transfer_app/DetailScreenPages/SettingScreens/change_username.dart';
import 'package:money_transfer_app/constants.dart';
import 'package:money_transfer_app/my_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsSettings extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DetailsSettings({Key? key}) : super(key: key);

  void _logoutAction(BuildContext context) async {
    final navigator = Navigator.of(context);

    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    showToast('signed out!');
    // Navigator.pushNamed(context, '/');
    navigator.pushNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'Settings',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 55.0),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 2.0,
                child: Container(
                  color: componentColor,
                ),
              ),
              const SizedBox(height: 5),
              SettingsButton(
                  buttonText: 'Change username',
                  buttonAction: () {
                    Navigator.pushNamed(context,
                        ChangeUserNameScreen.changeUserNameScreenRoute);
                  }),
              const SizedBox(height: 5),
              SettingsButton(
                  buttonText: 'Change password',
                  buttonAction: () {
                    Navigator.pushNamed(context,
                        ChangePasswordScreen.changePasswordScreenRoute);
                  }),
              const SizedBox(height: 5),
              SettingsButton(
                  buttonText: 'Logout',
                  buttonAction: () {
                    _logoutAction(context);
                  }),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            'version : 2.0.0',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonAction;
  const SettingsButton(
      {Key? key, required this.buttonText, required this.buttonAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            padding: EdgeInsets.zero,
            textColor: textColor,
            onPressed: buttonAction,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
