import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fishbowl/agreement.dart';
import 'package:fishbowl/algorithmic_feed_matcher.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/firebase_options.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/login.dart';
import 'package:fishbowl/bookmarks.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:fishbowl/obj/user.dart';
import 'package:fishbowl/portfolio.dart';
import 'package:fishbowl/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var settings = AppSettings(loggedIn: true, darkMode: false);
  runApp(MyApp(
    settings: settings,
  ));
}

class MyApp extends StatelessWidget {
  final AppSettings settings;

  const MyApp({super.key, required this.settings});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Nunito', color: Colors.white),
        ),
      ),
      title: 'Fishbowl',
      home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (c, s) => s.connectionState != ConnectionState.done
              ? Splash(
                  settings: settings,
                )
              : MyHomePage(
                  title: 'Flutter Demo Home Page',
                  settings: settings,
                )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final AppSettings settings;

  const MyHomePage({super.key, required this.title, required this.settings});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    // set up the auth state listener (setState() will be called when auth state changes)

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // if the user is logged in, then get the user's data from the database
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get()
            .then((documentSnapshot) {
          if (!documentSnapshot.exists) {
            return;
          }
          GlobalState().user = FishbowlUser.fromFirestore(documentSnapshot);
        });
      }

      setState(() {});
    });
  }

  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return (FirebaseAuth.instance.currentUser == null)
        ? LoginPage()
        : CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              height: 65,
              currentIndex: _currentTab,
              onTap: (index) {
                setState(() {
                  _currentTab = index;
                  GlobalState().popNavigator.value = !GlobalState()
                      .popNavigator
                      .value; // toggle the popNavigator value to force the navigator to pop to the first page
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_circle_fill),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bookmark_fill),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                ),
              ],
            ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                      builder: (context) => const FeedPage());
                case 1:
                  return CupertinoTabView(
                      builder: (context) => BookmarksPage());
                case 2:
                  return CupertinoTabView(
                      builder: (context) => PortfolioPage(
                            settings: widget.settings,
                          ));
                default:
                  return Container();
              }
            },
          );
  }
}
