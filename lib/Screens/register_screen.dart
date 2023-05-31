import 'package:flutter/material.dart';
import 'package:money_transfer_app/Components/error_dialog.dart';
import 'package:money_transfer_app/Components/my_buttons.dart';
import 'package:money_transfer_app/Components/text_field_widget.dart';
import 'package:money_transfer_app/Screens/details_screen.dart';
import 'package:money_transfer_app/constants.dart';
import 'package:money_transfer_app/Providers/provider_data.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:money_transfer_app/my_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  static String registerScreenRoute = 'registerScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();

  final TextEditingController _repwdController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _isLoading = false;

  void _inputAction(BuildContext context) async {
    var providerData = Provider.of<MyProvider>(context, listen: false);
    providerData.checkRegisterUsername(_usernameController.text);
    providerData.checkRegisterEmail(_emailController.text);
    providerData.checkRegisterPwd(_pwdController.text);
    providerData.checkRegisterRePwd(_repwdController.text);
    providerData.checkTwoPwdSame(_pwdController.text, _repwdController.text);

    setState(() {
      _isLoading = true;
    });

    if (!providerData.registerEmailError &&
        !providerData.registerUsernameError &&
        !providerData.registerPwdError &&
        !providerData.registerRePwdError &&
        providerData.twoPwdSame) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _pwdController.text,
        );
        await _db.collection('money').add({
          'username': _usernameController.text,
          'email': _emailController.text,
          'gold': 500,
        });
        showToast('Account created successfully.');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _auth.currentUser!.email!);
        await OneSignal.shared.setExternalUserId(_emailController.text.trim());
        if (!mounted) return;
        Provider.of<MyProvider>(context, listen: false).greetings = 'Welcome';
        Navigator.pushNamedAndRemoveUntil(
          context,
          DetailsScreen.detailsScreenRoute,
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              'E-mail already exists or bad e-mail format!',
              (context) {
                Navigator.pop(context);
              },
            );
          },
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        color: mainColor,
        progressIndicator: progressIndicator,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                hintText: 'Username',
                controller: _usernameController,
                error: Provider.of<MyProvider>(context).registerUsernameError
                    ? 'Empty username!'
                    : null,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'E-mail',
                controller: _emailController,
                error: Provider.of<MyProvider>(context).registerEmailError
                    ? 'Empty e-mail!'
                    : null,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Password',
                controller: _pwdController,
                error: Provider.of<MyProvider>(context).registerPwdError
                    ? Provider.of<MyProvider>(context).pwdNotSameErrorText
                    : null,
                isPwd: true,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Retype password',
                controller: _repwdController,
                error: Provider.of<MyProvider>(context).registerRePwdError
                    ? Provider.of<MyProvider>(context).pwdNotSameErrorText
                    : null,
                isPwd: true,
              ),
              const SizedBox(height: 10),
              CustomButton(
                buttonText: 'Register',
                action: () {
                  _inputAction(context);
                },
                width: 200.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
