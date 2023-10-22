import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/obj/company.dart';

class Investments {
  String? companyID;
  double? shares;

  Investments({
    this.companyID,
    this.shares,
  });

  factory Investments.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return Investments(
      companyID: snapshot.id,
      shares: data?['shares'],
    );
  }

  Future<Company> getCompany() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('companies')
        .doc(companyID)
        .get();
    return Company.fromFirestore(snapshot);
  }

  double getShares() {
    return shares!.toDouble();
  }

  Future<bool> uploadInvestment() async {
    try {
      await FirebaseFirestore.instance
          .collection('investments')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('interest')
          .doc(companyID)
          .set({
        'shares': shares,
      });
      return true;
    } catch (e) {
      print('Error uploading investment: $e');
      return false;
    }
  }
}
