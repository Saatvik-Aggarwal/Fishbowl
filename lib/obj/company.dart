import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String? name;
  String? aboutUs;
  List<Map<String, String>>? data;
  String? video;
  List<Map<String, String>>? founders;
  String? frontImage;

  Company(
      {this.aboutUs,
      this.data,
      this.video,
      this.founders,
      this.name,
      this.frontImage});

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
        frontImage: data?['front_image']);
  }

  String getAboutUs() {
    return aboutUs!;
  }

  List<Map<String, String>> getData() {
    return data!;
  }

  List<Map<String, String>> getFounders() {
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
}
