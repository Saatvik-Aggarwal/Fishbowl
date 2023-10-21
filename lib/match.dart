import 'package:fishbowl/appsettings.dart';
import 'package:flutter/cupertino.dart';

class MatchPage extends StatefulWidget {
  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

  @override
  void initState() {
    super.initState();
  }

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
