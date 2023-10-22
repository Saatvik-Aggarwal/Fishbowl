import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:fishbowl/success_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  const AgreementPage({
    Key? key,
    required this.company,
    required this.investment,
  }) : super(key: key);

  final Company company;
  final Investment investment;

  @override
  Widget build(BuildContext context) {
    String? userName = "Batyr Bhakta"; // TODO: get user name
    print("username is $userName!");
    String companyName = company.getName();
    print("username is $companyName");

    String companyID = company.getId();
    print("username is $companyID");

    double numberOfShares = investment.getShares();
    print("username is $numberOfShares");

    double pricePerShare = company.getPricePerShare();
    print("username is $pricePerShare");

    var date = new DateTime.now();
    int day = date.day;
    int monthIndex = date.month;
    List<String> monthsList = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String month = monthsList[monthIndex - 1];
    int year = date.year;

    return SingleChildScrollView(
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EQUITY FINANCING AGREEMENT',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navLargeTitleTextStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'This Equity Financing Agreement (the “Agreement”) is made and entered into as of $day $month $year, by and between $userName (the “Investor”), and $companyName (the “Company”).',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'WHEREAS, the Company desires to raise capital through the sale of equity securities; and\n\nWHEREAS, the Investor desires to purchase equity securities in the Company.\n\nNOW, THEREFORE, in consideration of the mutual promises and covenants contained herein, the parties agree as follows:',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '1. Purchase of Securities. The Investor agrees to purchase from the Company and the Company agrees to issue and sell to the Investor $numberOfShares shares of Class B stock (the “Shares”) at a price of \$$pricePerShare per Share.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '2. Closing. The closing of the purchase and sale of the Shares shall take place once the demonstrated interest matches the requested amount.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '3. Representations and Warranties of the Company. The Company represents and warrants to the Investor as follows:\n\na. Organization and Qualification. The Company is a corporation duly organized, validly existing, and in good standing under the laws of its state of incorporation.\n\nb. Authorization; Enforceability. The execution, delivery, and performance by the Company of this Agreement have been duly authorized by all necessary corporate action on the part of the Company.\n\nc. No Conflict. The execution, delivery, and performance by the Company of this Agreement do not conflict with or result in a breach or violation of any agreement or instrument to which it is a party or by which it is bound.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '4. Representations and Warranties of the Investor. The Investor represents and warrants to the Company as follows:\n\na. Authorization; Enforceability. The execution, delivery, and performance by the Investor of this Agreement have been duly authorized by all necessary action on the part of the Investor.\n\nb. No Conflict. The execution, delivery, and performance by the Investor of this Agreement do not conflict with or result in a breach or violation of any agreement or instrument to which it is a party or by which it is bound.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '5. Miscellaneous.\n\na. Governing Law; Jurisdiction; Venue. This Agreement shall be governed by and construed in accordance with the laws of Texas, without giving effect to any choice or conflict of law provision or rule that would cause the application of laws of any jurisdiction other than those of Texas. Any legal suit, action or proceeding arising out of or relating to this Agreement shall be instituted in a court of competent jurisdiction in Texas, and each party irrevocably submits to the jurisdiction of such court in any such suit, action or proceeding.\n\nb. Entire Agreement; Amendments; Waivers. This Agreement constitutes the entire agreement between the parties with respect to its subject matter and supersedes all prior agreements and understandings, whether written or oral, relating to such subject matter. This Agreement may be amended only by an instrument in writing executed by both parties hereto. No waiver by either party of any breach by the other party hereto shall be deemed a waiver of any subsequent breach.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'IN WITNESS WHEREOF, each party has executed this Agreement as of the date first above written.',
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        userName!,
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        companyName,
                        style: CupertinoTheme.of(context).textTheme.textStyle,
                      ),
                    ],
                  ),
                  // Add an "I Agree" button
                  CupertinoButton.filled(
                    child: const Text('I Agree'),
                    onPressed: () {
                      Investment newInvestment = Investment(
                          companyID: companyID, shares: numberOfShares);
                      // print("about to go");

                      newInvestment.uploadInvestment();
                      company
                          .updateCurrentTotal(numberOfShares * pricePerShare);
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SuccessPage(),
                        ),
                      );
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(CupertinoIcons.xmark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
