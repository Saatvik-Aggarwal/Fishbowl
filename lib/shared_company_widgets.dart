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

class CompanyInterestProgessBar extends StatelessWidget {
  final Company company;

  const CompanyInterestProgessBar({Key? key, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double currentTotal =
        company.currentTotal ?? 1.0; // Default to 1 to avoid division by zero
    double progress = (company.currentTotal! / company.goalAmount!) ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            LinearProgressIndicator(
              minHeight: 40,
              value: progress,
              backgroundColor: Color.fromARGB(255, 106, 120, 132),
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppSettings().getBackgroundColor()),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "\$" +
                      company.currentTotal.toString() +
                      " out of \$" +
                      company.goalAmount.toString() +
                      " raised", // This will display, for example, "50%"
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
