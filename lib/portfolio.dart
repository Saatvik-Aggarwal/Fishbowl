import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:flutter/cupertino.dart';

class PortfolioPage extends StatefulWidget {

  const PortfolioPage({
    super.key,
    required this.settings,
  });

  final AppSettings settings;

  @override
  Portfolio createState() => Portfolio();
}

class Portfolio extends State<PortfolioPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('investments')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          var doc;
          if (!snapshot.hasData) {
            return Container(
              color: widget.settings.getBackgroundColor(),
            );
          } else {
            doc = snapshot.data;
          }
          Investments invest = Investments.fromFirestore(doc!);
          return CupertinoApp(
            home: CupertinoPageScaffold(
              backgroundColor: widget.settings.getBackgroundColor(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "My Portfolio",
                        style: TextStyle(
                            color: widget.settings.getPrimaryColor(),
                            fontSize: 34,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            "Investments",
                            style: TextStyle(
                                color: widget.settings.getPrimaryColor(),
                                fontSize: 22,
                                fontWeight: FontWeight.w200),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: widget.settings.getPrimaryColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [Text(invest.getCompany())],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Text(
                            "Interests",
                            style: TextStyle(
                                color: widget.settings.getPrimaryColor(),
                                fontSize: 22,
                                fontWeight: FontWeight.w200),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            color: widget.settings.getPrimaryColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
