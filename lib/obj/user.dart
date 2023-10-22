import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/obj/company.dart';

class User {
  String? id;
  String? firstName;
  String? lastName;
  double? balance;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.balance});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return User(
      id: snapshot.id,
      firstName: data!['firstName'],
      lastName: data['lastName'],
      balance: data['balance'] ?? 0.0,
    );
  }

  String getFirstName() {
    return firstName!;
  }

  String getLastName() {
    return lastName!;
  }

  double getBalance() {
    return balance!.toDouble();
  }

  Future<bool> updateBalance(double updatedBy) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'balance': balance! - updatedBy,
      });
      return true;
    } catch (e) {
      print('Updating user balance failed: $e');
      return false;
    }
  }
}
