import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarksPage extends StatefulWidget {
  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final settings = AppSettings(loggedIn: true, darkMode: false);

  void popUntilFirst() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  void initState() {
    GlobalState().popNavigator.addListener(popUntilFirst);
    super.initState();
  }

  @override
  void dispose() {
    GlobalState().popNavigator.removeListener(popUntilFirst);
    super.dispose();
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
            Expanded(
                child: (GlobalState().user == null ||
                        GlobalState().user!.bookmarks.isEmpty)
                    ? Center(
                        child: Text(
                          "You have no bookmarks",
                          style: TextStyle(
                              color: settings.getPrimaryColor(),
                              fontSize: 18,
                              fontWeight: FontWeight.w200),
                        ),
                      )
                    : ListView.builder(
                        itemCount: GlobalState().user!.bookmarks.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(GlobalState()
                                .companies[
                                    GlobalState().user!.bookmarks[index]]!
                                .name!),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SingleFeedPage(
                                    company: GlobalState().companies[
                                        GlobalState().user!.bookmarks[index]]!,
                                  ),
                                ),
                              );
                            },
                          ));
                        },
                      ))
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
