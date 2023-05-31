import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:money_transfer_app/Components/error_dialog.dart';
import 'package:money_transfer_app/Components/my_buttons.dart';
import 'package:money_transfer_app/Components/text_field_widget.dart';
import 'package:money_transfer_app/Providers/provider_data.dart';
import 'package:money_transfer_app/Screens/details_screen.dart';
import 'package:money_transfer_app/constants.dart';
import 'package:money_transfer_app/my_functions.dart';
import 'package:provider/provider.dart';

class ChangeUserNameScreen extends StatefulWidget {
  static String changeUserNameScreenRoute = 'changeUserNameRoute';

  const ChangeUserNameScreen({Key? key}) : super(key: key);

  @override
  State<ChangeUserNameScreen> createState() => _ChangeUserNameScreenState();
}

class _ChangeUserNameScreenState extends State<ChangeUserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _pwdController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  void _chgUserName(BuildContext context) async {
    Provider.of<MyProvider>(context, listen: false)
        .checkChgUsernameName(_userNameController.text);
    Provider.of<MyProvider>(context, listen: false)
        .checkChgUsernamePwd(_pwdController.text);

    setState(() {
      isLoading = true;
    });
    if (!Provider.of<MyProvider>(context, listen: false).chgUsernamePwdError &&
        !Provider.of<MyProvider>(context, listen: false).chgUsernameNameError) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: _auth.currentUser!.email!, password: _pwdController.text);
        if (await getMyInfo(arg: 'username') == _userNameController.text) {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              'You can\'t change same username.',
              (context) {
                Navigator.pop(context);
              },
            ),
          );
        } else {
          _db.collection('money').doc(await getMyId()).update({
            'username': _userNameController.text,
          });
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              'Changed to username \'${_userNameController.text}\' successfully.',
              (context) {
                Navigator.pushNamed(context, DetailsScreen.detailsScreenRoute);
              },
              optionalTitle: 'Success',
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            'Wrong Password.',
            (context) {
              Navigator.pop(context);
            },
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: mainColor,
      progressIndicator: progressIndicator,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Change Username'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                MyTextField(
                    hintText: 'New username',
                    controller: _userNameController,
                    error: Provider.of<MyProvider>(context).chgUsernameNameError
                        ? 'Username can\'t be empty!'
                        : null),
                const SizedBox(height: 10),
                MyTextField(
                    isPwd: true,
                    hintText: 'Password',
                    controller: _pwdController,
                    error: Provider.of<MyProvider>(context).chgUsernamePwdError
                        ? 'Password can\'t be empty!'
                        : null),
                const SizedBox(height: 10),
                CustomButton(
                  buttonText: 'Change Username',
                  action: () {
                    _chgUserName(context);
                  },
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
