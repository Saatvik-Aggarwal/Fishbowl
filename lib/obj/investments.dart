import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/obj/company.dart';

class Investment {
  String? companyID;
  double? shares;

  Investment({
    this.companyID,
    this.shares,
  });

  factory Investment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return Investment(
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

    if (!snapshot.exists) {
      print("Company does not exist!");
      throw Exception('Company does not exist!');
    }

    // Company c = Company.fromFirestore(snapshot);

    // print("Company is null? " + (c == null).toString());

    return Company.fromFirestore(snapshot);
  }

  double getShares() {
    return (shares ?? 0);
  }

  @override
  String toString() {
    return 'Company ID: ${companyID ?? "UNKNOWN"}, Shares: ${shares ?? -1}';
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
