import 'package:cloud_firestore/cloud_firestore.dart';

class Information {
  String? about_us;
  String? data;
  String? video;

  Information({
    this.about_us,
    this.data,
    this.video,
  });

  factory Information.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, [
    SnapshotOptions? options,
  ]) {
    final data = snapshot.data();
    return Information(
      about_us: data?['about_us'],
      data: data?['data'],
      video: data?['video'],
    );
  }

  String getAboutUs() {
    return about_us!;
  }

  // List<List<String>> getData(String dataIn) {
  //   // String[] parsedData = dataIn.split("");

  //   // List<>
  //   // TODO: implement getData

  //   List<String> parsedData = dataIn.split("@");
  //   List<String> images;
  //   List<String> text;

  //   for (int i = 0; i < parsedData.length; i++) {
  //     List<String> dataPiece = parsedData[i].split("|");
  //     if (dataPiece[0] === "text") {
  //       text.
  //     }
  //   }

  //   return data!;
  // }

  String getVideoURL() {
    return video!;
  }
}
