import 'package:fishbowl/agreement.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:fishbowl/shared_company_widgets.dart';
import 'package:flutter/cupertino.dart';

class InvestPage extends StatefulWidget {
  final Company company;

  const InvestPage({Key? key, required this.company}) : super(key: key);

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int dollarAmount = 100;
  TextEditingController dollarAmountController = TextEditingController(
    text: "100",
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppSettings().getPrimaryColor(),
        child: Column(
          children: [
            Row(
              children: [
                // Back button
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppSettings().getTextOnPrimaryColor(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  widget.company.getName(),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppSettings(darkMode: true, loggedIn: true)
                        .getSecondaryColor(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            CompanyInterestProgessBar(company: widget.company),
            const SizedBox(height: 20),
            // Add a text box which shows the dollar amount (and updates as the slider is moved and can be edited)
            CupertinoTextField(
              controller: dollarAmountController,
              keyboardType: TextInputType.number,
              prefix: const Text("\$"),
              onChanged: (value) {
                setState(() {
                  dollarAmount = int.tryParse(value) ?? dollarAmount;
                });
              },
            ),

            const Spacer(),

            // Confirm Interest button
            CupertinoButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AgreementPage(
                              company: widget.company,
                              investment: Investment(
                                  companyID: widget.company.id,
                                  shares: dollarAmount /
                                      widget.company.pricePerShare!),
                            )));
              },
              color: AppSettings().getSecondaryColor(),
              borderRadius: BorderRadius.circular(16),
              child: Text(
                "Confirm Interest",
                style: TextStyle(
                  fontSize: 24,
                  color: AppSettings(darkMode: true, loggedIn: true)
                      .getTextOnSecondaryColor(),
                ),
              ),
            ),
            // Smaller save for later button

            CupertinoButton(
              onPressed: () {
                // TODO: Add to saved companies

                Navigator.pop(context);
              },
              color: AppSettings().getPrimaryColor(),
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(0),
              child: Text(
                "Save for Later",
                style: TextStyle(
                  fontSize: 14,
                  color: AppSettings(darkMode: true, loggedIn: true)
                      .getTextOnPrimaryColor(),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ));
  }
}
