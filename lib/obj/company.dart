import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Company {
  String? name;
  String? aboutUs;
  List<dynamic>? data;
  String? video;
  List<dynamic>? founders;
  String? frontImage;
  double? pricePerShare;
  double? goalAmount;
  double? currentTotal;
  String? id;

  Company(
      {this.aboutUs,
      this.data,
      this.video,
      this.founders,
      this.name,
      this.frontImage,
      this.pricePerShare,
      this.goalAmount,
      this.currentTotal,
      required this.id});

  factory Company.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return Company(
        aboutUs: data?['about_us'],
        data: data?['data'],
        video: data?['video'],
        founders: data?['founders'],
        name: data?['name'],
        frontImage: data?['front_image'],
        pricePerShare: data?['price_per_share']?.toDouble(),
        goalAmount: data?['goal_amount']?.toDouble(),
        currentTotal: data?['current_total']?.toDouble(),
        id: snapshot.id);
  }

  String getAboutUs() {
    return aboutUs!;
  }

  List<dynamic> getData() {
    return data!;
  }

  List<dynamic> getFounders() {
    return founders!;
  }

  String getVideoURL() {
    return video!;
  }

  String getName() {
    return name!;
  }

  String getFrontImage() {
    return frontImage!;
  }

  String getId() {
    return id!;
  }

  double getPricePerShare() {
    return pricePerShare!;
  }

  double getGoalAmount() {
    return goalAmount!;
  }

  double getCurrentTotal() {
    return currentTotal!;
  }

  Future<bool> updateCurrentTotal(double amountInterest) async {
    try {
      currentTotal = currentTotal! + amountInterest;
      await FirebaseFirestore.instance.collection('companies').doc(id).set({
        'current_total': currentTotal,
      });
      return true;
    } catch (e) {
      print('Updating company current total failed: $e');
      return false;
    }
  }
}
