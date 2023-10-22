import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Company> companies = [];

  @override
  void initState() {
    super.initState();

    // Get all the companies in the /companies collection

    FirebaseFirestore.instance
        .collection('companies')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        companies.add(Company.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        ));
      }

      setState(() {
        companies = companies;
        // print companies
        for (var company in companies) {
          print(company);
        }

        GlobalState().currentVideoCompanyId.value = companies[0].id!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppSettings().getPrimaryColor(),
        child: companies.isEmpty
            ? const Center(child: CupertinoActivityIndicator())
            : SwipableStack(
                allowVerticalSwipe: false,
                onSwipeCompleted: (index, direction) {
                  GlobalState().currentVideoCompanyId.value =
                      companies[(index + 1) % companies.length].id!;
                },
                builder: (context, properties) {
                  return SingleFeedPage(
                      company: companies[properties.index % companies.length]);
                }));
  }
}
