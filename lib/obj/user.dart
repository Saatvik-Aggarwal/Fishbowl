import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/obj/company.dart';

class User {
  String id;
  String? firstName;
  String? lastName;
  List? industries;
  double balance;
  List<String> bookmarks;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.industries,
      required this.balance,
      this.bookmarks = const []});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return User(
      id: snapshot.id,
      firstName: data!['firstName'],
      lastName: data['lastName'],
      industries: data['industries'],
      balance: data['balance'] ?? 0.0,
      bookmarks: data['bookmarks'] ?? [],
    );
  }

  String getFirstName() {
    return firstName!;
  }

  String getLastName() {
    return lastName!;
  }

  List getIndustries() {
    return industries!;
  }

  double getBalance() {
    return balance!.toDouble();
  }

  Future<bool> updateBalance(double decreaseBy) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'balance': balance! - decreaseBy,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Updating user balance failed: $e');
      return false;
    }
  }

  Future<bool> updateBookmarks() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'bookmarks': bookmarks,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Updating user bookmarks failed: $e');
      return false;
    }
  }
}
