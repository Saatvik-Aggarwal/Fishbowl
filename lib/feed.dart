import 'package:flutter/cupertino.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

  VideoPlayerController _controller = VideoPlayerController.networkUrl(Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    _controller.setLooping(true);
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
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: VideoPlayer(_controller),
          ),
          // Display Company Name
          Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                  child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Unilever_Logo.svg/1200px-Unilever_Logo.svg.png'),
                ),
                Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Unilever",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "UL",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "123.45",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
