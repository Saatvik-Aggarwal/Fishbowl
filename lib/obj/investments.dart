import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/obj/company.dart';

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

  Future<Company> getCompany() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('companies')
        .doc(company)
        .get();
    return Company.fromFirestore(snapshot);
  }

  double getShares() {
    return shares!.toDouble();
  }

}
