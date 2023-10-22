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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "My Interests",
                  style: TextStyle(
                      color: settings.getPrimaryColor(),
                      fontSize: 22,
                      fontWeight: FontWeight.w200),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [for (int i = 0; i < 5; i++) ...interestIcons()],
              ),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  List<Widget> interestIcons() {
    return [
      Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
            color: settings.getPrimaryColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)),
      ),
      SizedBox(width: 10) // Adjust the width as needed
    ];
  }
}
