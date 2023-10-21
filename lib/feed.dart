import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedPage extends StatefulWidget {
  final String companyId;

  const FeedPage({Key? key, required this.companyId}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

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

        _controller.initialize().then((_) => setState(() {}));
        _controller.play();
        _controller.setLooping(true);
      });
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
          : SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(_controller),
                ),
                // Display Company Name
                Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(
                      children: [
                        // Name, Picture, About, Founders, Data
                        // Name
                        Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              companyInfo!.getName(),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color:
                                    AppSettings(darkMode: true, loggedIn: true)
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
                        Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              companyInfo?.getAboutUs() ?? "",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Founders
                        Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Founders",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Data
                        Container(
                          height: 100,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Data",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
    );
  }
}
