import 'package:fishbowl/appsettings.dart';
import 'package:flutter/cupertino.dart';

class Splash extends StatefulWidget {
  AppSettings settings;

  Splash({
    super.key,
    required this.settings,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: widget.settings.getBackgroundColor(),
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
                  color: widget.settings.getPrimaryColor(),
                  fontSize: 48),
            ),
            Text(
              "Fishbowl",
              style: TextStyle(
                  color: widget.settings.getSecondaryColor(),
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
