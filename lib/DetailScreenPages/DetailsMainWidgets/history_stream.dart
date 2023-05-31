import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_transfer_app/constants.dart';

// import '../../datamodels/history_data.dart';

class HistoryStream extends StatelessWidget {
  const HistoryStream({
    Key? key,
    required FirebaseFirestore db,
    required FirebaseAuth auth,
  })  : _db = db,
        _auth = auth,
        super(key: key);

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('history')
          .doc('${_auth.currentUser?.email} history')
          .collection('history data')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Center(
              child: progressIndicator,
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(top: 70),
            child: const Center(
              child: Text(
                'No data',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }

        final data = snapshot.data!.docs;

        // List<HistoryData> historyData = [];
        // for (var i in data) {
        //   historyData.add(HistoryData(
        //       timestamp: i.get('time'),
        //       amount: i.get('amount'),
        //       toWho: i.get('transfer')));
        // }

        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListView.builder(
              itemCount: data.length > 15 ? 15 : data.length,
              itemBuilder: (context, index) {
                final historyData = data[index].data() as Map<String, dynamic>;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      decoration: BoxDecoration(
                        color: componentColor,
                        borderRadius: index == 0 && data.length == 1
                            ? const BorderRadius.all(
                                Radius.circular(15),
                              )
                            : index == 0
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )
                                : index == 14 || index == data.length - 1
                                    ? const BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      )
                                    : BorderRadius.zero,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              historyData['transfer'],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              historyData['transfer'].contains('from') ||
                                      historyData['transfer'] == 'Loan'
                                  ? '+${historyData['amount']} \$'
                                  : '-${historyData['amount']} \$',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              historyData['time']
                                  .toDate()
                                  .toString()
                                  .substring(0, 16),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
