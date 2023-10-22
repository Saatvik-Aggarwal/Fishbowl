import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/invest.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/shared_company_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

class SingleFeedPage extends StatefulWidget {
  final Company company;

  const SingleFeedPage({Key? key, required this.company}) : super(key: key);

  @override
  State<SingleFeedPage> createState() => _SingleFeedPageState();
}

class _SingleFeedPageState extends State<SingleFeedPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);
  final mainScrollController = ScrollController();
  final pageController = PageController();
  final focusNode = FocusNode();
  String? completionText; // To hold the text returned by OpenAI

  late final VideoPlayerController _controller =
      VideoPlayerController.networkUrl(Uri.parse(widget.company.getVideoURL()));

  late List<Map<String, dynamic>> investmentData = [];

  @override
  void initState() {
    super.initState();
    // fetchOpenAICompletion();
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });

    _controller.setLooping(true);

    // Fetch investment data for the specific company
    fetchInvestmentData();
  }

  // Fetch investment data for the specific company
  Future<void> fetchInvestmentData() async {
    final companyID = widget.company.id;

    if (companyID != null) {
      final List<Map<String, dynamic>> data = [];

      for (String s in widget.company.investors) {
        await FirebaseFirestore.instance
            .collection('investments')
            .doc(s)
            .collection('interest')
            .doc(companyID)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.exists) {
            data.add({
              'userID': s,
              'shares': snapshot.data()?['shares'],
            });
          }
        });
      }

      setState(() {
        investmentData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: Key(widget.company.id!),
      backgroundColor: settings.getBackgroundColor(),
      child: PageView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          pageSnapping: true,
          onPageChanged: (index) {
            if (index == 0) {
              _controller.play();
            } else {
              _controller.pause();
              focusNode.requestFocus();
            }
          },
          controller: pageController,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(_controller),
            ),
            // Display Company Name
            Focus(
              focusNode: focusNode,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: mainScrollController,
                child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        // Name, Picture, About, Founders, Data
                        // Name
                        SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              widget.company.getName(),
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppSettings(darkMode: true, loggedIn: true)
                                        .getBackgroundColor(),
                              ),
                            ),
                          ),
                        ),
                        // Picture
                        Image.network(
                          widget.company.getFrontImage(),
                        ),
                        // About
                        CompanyAboutCard(companyInfo: widget.company),
                        // Founders
                        SizedBox(
                          child: Center(
                            child: Text(
                              "The Founders",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppSettings(darkMode: true, loggedIn: true)
                                        .getBackgroundColor(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 500,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                          ),
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  widget.company.getFounders().length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.company.getFounders()[index]
                                                  ["image"] ??
                                              ""),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      widget.company.getFounders()[index]
                                              ["name"] ??
                                          "Unknown",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppSettings(
                                                darkMode: true, loggedIn: true)
                                            .getTextOnPrimaryColor(),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        widget.company.getFounders()[index]
                                                ["about_me"] ??
                                            "Unknown",
                                        maxLines: 13,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppSettings(
                                                  darkMode: true,
                                                  loggedIn: true)
                                              .getTextOnPrimaryColor(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        // Data
                        Card(
                          margin: const EdgeInsets.all(36),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.company.getData().length ?? 0,
                                  itemBuilder: (context, index) {
                                    return widget.company.getData()[index]
                                                ["type"] ==
                                            "text"
                                        ? Text(
                                            widget.company.getData()[index]
                                                    ["data"] ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppSettings(
                                                      darkMode: true,
                                                      loggedIn: true)
                                                  .getBackgroundColor(),
                                            ),
                                          )
                                        : Image.network(
                                            widget.company.getData()[index]
                                                    ["data"] ??
                                                "",
                                            fit: BoxFit.fitWidth);
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 8);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  16.0), // Add horizontal padding for a small indent
                          child: Text(
                            "Investment Progress",
                            style: TextStyle(
                                color: settings.getBackgroundColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        CompanyInterestProgessBar(company: widget.company),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  16.0), // Add horizontal padding for a small indent
                          child: Text(
                            "Investment Ledger",
                            style: TextStyle(
                                color: settings.getBackgroundColor(),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              elevation: 4,
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text('User ID'),
                                  ),
                                  DataColumn(
                                    label: Text('\$'),
                                  ),
                                ],
                                rows: investmentData.map((data) {
                                  final userID = data['userID'];
                                  final shares = data['shares'];
                                  final investmentAmount =
                                      calculateInvestmentAmount(shares);
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(userID)),
                                      DataCell(Text(
                                          '\$${investmentAmount.toStringAsFixed(2)}')),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(36),
                          child: Row(
                            // small bookmark button, "interested"
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: CupertinoButton(
                                  padding:
                                      const EdgeInsets.all(0), // No padding

                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => InvestPage(
                                                company: widget.company)));
                                  },
                                  color: AppSettings(
                                          darkMode: true, loggedIn: true)
                                      .getBackgroundColor(),
                                  child: Text(
                                    "Interested",
                                    style: TextStyle(
                                        color: AppSettings(
                                                darkMode: true, loggedIn: true)
                                            .getTextOnSecondaryColor()),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppSettings(
                                          darkMode: true, loggedIn: true)
                                      .getBackgroundColor(),
                                ),
                                padding: const EdgeInsets.all(0), // No padding
                                height: 50,
                                width: 70,
                                child: IconButton(
                                    icon: Icon(
                                      GlobalState()
                                              .user!
                                              .bookmarks
                                              .contains(widget.company.id)
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                    ),
                                    onPressed: () {
                                      if (GlobalState()
                                          .user!
                                          .bookmarks
                                          .contains(widget.company.id)) {
                                        GlobalState()
                                            .user!
                                            .bookmarks
                                            .remove(widget.company.id);
                                      } else {
                                        GlobalState()
                                            .user!
                                            .bookmarks
                                            .add(widget.company.id!);
                                      }

                                      GlobalState().user!.updateBookmarks();

                                      setState(() {});
                                    },
                                    color: AppSettings(
                                            darkMode: true, loggedIn: true)
                                        .getPrimaryColor()),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 80)
                      ],
                    )),
              ),
            ),
          ]),
    );
  }

  double calculateInvestmentAmount(double shares) {
    if (widget.company.pricePerShare != null) {
      return shares * widget.company.pricePerShare!;
    }
    return 0.0; // Return 0 if pricePerShare is not available
  }

  promptGen() {
    return "How old am I?";
  }
}
