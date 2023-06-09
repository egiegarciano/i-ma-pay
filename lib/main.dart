import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:money_transfer_app/DetailScreenPages/DetailsPayBill/bill_pay_screen.dart';
import 'package:money_transfer_app/DetailScreenPages/DetailsTopUp/credit_card_buy_history.dart';
import 'package:money_transfer_app/DetailScreenPages/SettingScreens/change_password.dart';
import 'package:money_transfer_app/DetailScreenPages/SettingScreens/change_username.dart';
import 'package:money_transfer_app/Screens/details_screen.dart';
import 'package:money_transfer_app/DetailScreenPages/DetailsTopUp/gift_card_buy_screen.dart';
import 'package:money_transfer_app/Screens/home.dart';
import 'package:money_transfer_app/Screens/loan_screen.dart';
import 'package:money_transfer_app/Screens/login_screen.dart';
import 'package:money_transfer_app/Screens/register_screen.dart';
import 'package:money_transfer_app/DetailScreenPages/DetailsTopUp/top_up_page.dart';
import 'package:money_transfer_app/Providers/provider_data.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.get('email');

  runApp(MyApp(email == null ? '/' : DetailsScreen.detailsScreenRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  const MyApp(this.initialRoute, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    createSignalInstance();
    setExteranlID();
  }

  void createSignalInstance() async {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId(kAppId);
  }

  void setExteranlID() async {
    if (widget.initialRoute == '/') {
      return;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.get('email');
      await OneSignal.shared.setExternalUserId(email.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyProvider>(create: (context) => MyProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mainColor,
          appBarTheme: AppBarTheme(
            backgroundColor: mainColor,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: mainColor,
            selectedIconTheme: IconThemeData(
              color: textColor,
            ),
            selectedItemColor: textColor,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: textColor,
                displayColor: textColor,
                fontFamily: 'Poppin',
              ),
        ),
        initialRoute: widget.initialRoute,
        routes: {
          '/': (context) => const HomeScreen(),
          LoginScreen.loginScreenRoute: (context) => const LoginScreen(),
          RegisterScreen.registerScreenRoute: (context) =>
              const RegisterScreen(),
          DetailsScreen.detailsScreenRoute: (context) => const DetailsScreen(),
          TopUpPage.topUpPageRoute: (context) => const TopUpPage(),
          GiftCardBuy.giftCardBuyRoute: (context) => GiftCardBuy(),
          BillPay.billPayRoute: (context) => BillPay(),
          LoanScreen.loanScreenRoute: (context) => LoanScreen(),
          ChangePasswordScreen.changePasswordScreenRoute: (context) =>
              const ChangePasswordScreen(),
          ChangeUserNameScreen.changeUserNameScreenRoute: (context) =>
              const ChangeUserNameScreen(),
          CreditCardHistoryScreen.creditCardHistoryScreenRoute: (context) =>
              CreditCardHistoryScreen(),
        },
      ),
    );
  }
}
