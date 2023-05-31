import 'package:flutter/material.dart';
import 'package:money_transfer_app/Components/my_buttons.dart';
import 'package:money_transfer_app/DetailScreenPages/DetailsLoanScreenParts/get_loan_modal.dart';
import 'package:money_transfer_app/DetailScreenPages/DetailsLoanScreenParts/repay_loan.dart';

class LoanScreen extends StatelessWidget {
  static String loanScreenRoute = 'loanScreenRoute';
  final TextEditingController controller = TextEditingController();

  LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Loan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Loan Service',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
          CustomButton(
            buttonText: 'Get Loan \$500',
            action: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => GetLoanModal(controller),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          CustomButton(
            buttonText: 'Repay Loan',
            action: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => RepayLoanModal(controller),
              );
            },
          ),
        ],
      ),
    );
  }
}
