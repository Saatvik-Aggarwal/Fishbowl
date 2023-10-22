import 'package:fishbowl/agreement.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/etc/hexcolor.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:fishbowl/shared_company_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  int dollarAmount = 0;
  TextEditingController dollarAmountController = TextEditingController(
    text: "0",
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
                      .getBackgroundColor(),
                ),
              ),
            ),
          ),
          CompanyInterestProgessBar(company: widget.company),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CompanyAboutCard(
                    companyInfo: widget.company,
                    titleSize: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Container(
                      width: double.infinity,
                      height: 135,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 36, right: 36, top: 24),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Amount to Invest",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppSettings(
                                                darkMode: true, loggedIn: true)
                                            .getTextOnPrimaryColor(),
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            16), // Add a little space between the text and input
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CupertinoTextField(
                                          controller: dollarAmountController,
                                          keyboardType: TextInputType.number,
                                          prefix: const Text(
                                            " \$",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          decoration: BoxDecoration(
                                            color: HexColor("FFFFFF"),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          onChanged: (value) {
                                            setState(() {
                                              dollarAmount =
                                                  int.tryParse(value) ??
                                                      dollarAmount;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "Amount of Shares",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppSettings(
                                                darkMode: true, loggedIn: true)
                                            .getTextOnPrimaryColor(),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${(dollarAmount / (widget.company.pricePerShare ?? 1.0)).toStringAsFixed(2)} shares",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppSettings(
                                                    darkMode: true,
                                                    loggedIn: true)
                                                .getTextOnPrimaryColor(),
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // In case of overflow, ellipsis will be used
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 72,
                    height: 40,
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: (dollarAmount == 0 ||
                              dollarAmount > GlobalState().user!.balance)
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => AgreementPage(
                                    company: widget.company,
                                    investment: Investment(
                                      companyID: widget.company.id,
                                      shares: dollarAmount /
                                          widget.company.pricePerShare!,
                                    ),
                                  ),
                                ),
                              );
                            },
                      color: AppSettings(darkMode: true, loggedIn: true)
                          .getBackgroundColor(),
                      child: Text(
                        "Confirm Interest",
                        style: TextStyle(
                          color: AppSettings(darkMode: true, loggedIn: true)
                              .getTextOnSecondaryColor(),
                        ),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      if (!GlobalState()
                          .user!
                          .bookmarks
                          .contains(widget.company.id)) {
                        GlobalState().user!.bookmarks.add(widget.company.id!);
                      }

                      GlobalState().user!.updateBookmarks();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
