import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:flutter/cupertino.dart';

class BookmarksPage extends StatefulWidget {
  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
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
            Text(
              "Bookmarks",
              style: TextStyle(
                  color: settings.getPrimaryColor(),
                  fontSize: 28,
                  fontWeight: FontWeight.w200),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: GlobalState().user == null ?
            //   )
            // )
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
