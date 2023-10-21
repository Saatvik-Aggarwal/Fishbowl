import 'package:flutter/cupertino.dart';
import 'package:fishbowl/appsettings.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: settings.getBackgroundColor(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "welcome to",
              style: TextStyle(
                  fontFamily: "GeneralSans",
                  // fontStyle: FontStyle.italic,
                  color: settings.getPrimaryColor(),
                  fontSize: 48),
            ),
            Text(
              "Fishbowl",
              style: TextStyle(
                  color: settings.getSecondaryColor(),
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
