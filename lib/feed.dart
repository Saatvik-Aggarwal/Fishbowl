import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/invest.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/shared_company_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

class FeedPage extends StatefulWidget {
  final String companyId;

  const FeedPage({Key? key, required this.companyId}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

  final mainScrollController = ScrollController();
  final pageController = PageController();
  final focusNode = FocusNode();

  VideoPlayerController _controller = VideoPlayerController.networkUrl(Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

  Company? companyInfo;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.companyId)
        .get()
        .then((value) {
      setState(() {
        companyInfo = Company.fromFirestore(value);
        _controller = VideoPlayerController.networkUrl(
            Uri.parse(companyInfo?.getVideoURL() ?? ""));

        _controller.initialize().then((_) {
          setState(() {});
          _controller.play();
        });

        _controller.setLooping(true);
      });
    });

    mainScrollController.addListener(() {
      if (mainScrollController.offset <=
          mainScrollController.position.minScrollExtent - 100) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: settings.getBackgroundColor(),
      child: companyInfo == null
          ? const Center(child: CupertinoActivityIndicator())
          : PageView(
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
                                    companyInfo!.getName(),
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: AppSettings(
                                              darkMode: true, loggedIn: true)
                                          .getSecondaryColor(),
                                    ),
                                  ),
                                ),
                              ),
                              // Picture
                              Image.network(
                                companyInfo!.getFrontImage(),
                              ),
                              // About
                              CompanyAboutCard(companyInfo: companyInfo!),
                              // Founders
                              SizedBox(
                                child: Center(
                                  child: Text(
                                    "The Founders",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: AppSettings(
                                              darkMode: true, loggedIn: true)
                                          .getSecondaryColor(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 400,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.9,
                                ),
                                child: Center(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        companyInfo?.getFounders().length ?? 0,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                companyInfo?.getFounders()[
                                                        index]["image"] ??
                                                    ""),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            companyInfo?.getFounders()[index]
                                                    ["name"] ??
                                                "Unknown",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: AppSettings(
                                                      darkMode: true,
                                                      loggedIn: true)
                                                  .getTextOnPrimaryColor(),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              companyInfo?.getFounders()[index]
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
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "The Data",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppSettings(
                                                    darkMode: true,
                                                    loggedIn: true)
                                                .getTextOnPrimaryColor(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            companyInfo?.getData().length ?? 0,
                                        itemBuilder: (context, index) {
                                          return companyInfo?.getData()[index]
                                                      ["type"] ==
                                                  "text"
                                              ? Text(
                                                  companyInfo?.getData()[index]
                                                          ["data"] ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppSettings(
                                                            darkMode: true,
                                                            loggedIn: true)
                                                        .getTextOnPrimaryColor(),
                                                  ),
                                                )
                                              : Image.network(
                                                  companyInfo?.getData()[index]
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
                              Row(
                                // small bookmark button, "interested"
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) => InvestPage(
                                                  company: companyInfo!)));
                                    },
                                    color: AppSettings(
                                            darkMode: true, loggedIn: true)
                                        .getSecondaryColor(),
                                    child: Text(
                                      "Interested",
                                      style: TextStyle(
                                          color: AppSettings(
                                                  darkMode: true,
                                                  loggedIn: true)
                                              .getTextOnSecondaryColor()),
                                    ),
                                  ),
                                  CupertinoButton(
                                    onPressed: () {},
                                    color: AppSettings(
                                            darkMode: true, loggedIn: true)
                                        .getSecondaryColor(),
                                    child: Icon(CupertinoIcons.bookmark,
                                        color: AppSettings(
                                                darkMode: true, loggedIn: true)
                                            .getPrimaryColor()),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              ),

                              const SizedBox(height: 80)
                            ],
                          )),
                    ),
                  ),
                ]),
    );
  }
}
