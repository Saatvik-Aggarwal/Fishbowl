import 'package:cloud_firestore/cloud_firestore.dart';

class Investments {

  String? company;
  int? shares;

  Investments({
    this.company,
    this.shares,
  });

  factory Investments.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return Investments(
      company: data?['company'],
      shares: data?['shares'],
    );
  }

  String getCompany() {
    FirebaseFirestore.instance
        .collection('companies')
        .doc(company!)
        .get()
        .then((value) {
      print(value.data());
    });
    return company!;
  }

  double getShares() {
    return shares!.toDouble();
  }

}
