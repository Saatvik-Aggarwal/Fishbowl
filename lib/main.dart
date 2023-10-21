import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/firebase_options.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/login.dart';
import 'package:fishbowl/match.dart';
import 'package:fishbowl/portfolio.dart';
import 'package:fishbowl/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
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
      title: 'Flutter Demo',

      //
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
  AppSettings settings;

  MyHomePage({super.key, required this.title, required this.settings});

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
      setState(() {});
    });
  }

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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_circle_fill),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                ),
              ],
            ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  // return Portfolio(
                  //   settings: widget.settings,
                  // );
                  return FeedPage();
                case 1:
                  return MatchPage();
                case 2:
                  return Portfolio(
                    settings: widget.settings,
                  );
                default:
                  return Container();
              }
            },
          );
  }
}
