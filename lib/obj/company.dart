import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/globalstate.dart';

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
  List<dynamic>? industries;
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
      this.industries,
      required this.id});

  factory Company.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    // print("DATA: $data");
    Company c = Company(
        aboutUs: data?['about_us'],
        data: data?['data'],
        video: data?['video'],
        founders: data?['founders'],
        name: data?['name'],
        frontImage: data?['front_image'],
        pricePerShare: data?['price_per_share'],
        goalAmount: data?['goal_amount'],
        currentTotal: data?['current_total'],
        industries: data?['industries'],
        id: snapshot.id);

    GlobalState().companies[c.id!] = c;
    return c;
  }

  List<dynamic> getIndustries() {
    return industries!;
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
    return frontImage ?? "https://placehold.co/600x400/EEE/31343C";
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
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Updating company current total failed: $e');
      return false;
    }
  }

  @override
  String toString() {
    return 'Company ID: ${id ?? "UNKNOWN"}, Name: ${name ?? "UNKNOWN"}'; //, About Us: ${aboutUs ?? "UNKNOWN"}, Data: ${data ?? "UNKNOWN"}, Video: ${video ?? "UNKNOWN"}, Founders: ${founders ?? "UNKNOWN"}, Front Image: ${frontImage ?? "UNKNOWN"}, Price Per Share: ${pricePerShare ?? "UNKNOWN"}, Goal Amount: ${goalAmount ?? "UNKNOWN"}, Current Total: ${currentTotal ?? "UNKNOWN"}';
  }
}
