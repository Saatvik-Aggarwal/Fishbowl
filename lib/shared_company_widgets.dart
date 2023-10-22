import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:flutter/material.dart';

class CompanyAboutCard extends StatelessWidget {
  final Company companyInfo;
  final int titleSize;
  final int bodySize;

  const CompanyAboutCard(
      {Key? key,
      required this.companyInfo,
      this.titleSize = 20,
      this.bodySize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(36),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About Us",
                style: TextStyle(
                  fontSize: titleSize as double,
                  fontWeight: FontWeight.bold,
                  color: AppSettings(darkMode: true, loggedIn: true)
                      .getTextOnPrimaryColor(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              companyInfo.getAboutUs(),
              style: TextStyle(
                fontSize: bodySize as double,
                color: AppSettings(darkMode: true, loggedIn: true)
                    .getTextOnPrimaryColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
