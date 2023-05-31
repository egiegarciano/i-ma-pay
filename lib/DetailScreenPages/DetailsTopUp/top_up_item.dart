import 'package:flutter/material.dart';
import 'package:money_transfer_app/constants.dart';

import 'package:money_transfer_app/datamodels/gift_card.dart';

class TopUpItems extends StatelessWidget {
  final List<GiftCard> cardList;
  final int itemIndex;
  final VoidCallback buttonAction;
  const TopUpItems(
      {Key? key,
      required this.cardList,
      required this.itemIndex,
      required this.buttonAction})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: componentColor,
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: buttonAction,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 120,
              child: Image.network(cardList[itemIndex].imgUrl),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                cardList[itemIndex].name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
