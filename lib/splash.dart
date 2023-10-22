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
            Image.asset(
              'assets/logo/png/logo-white-transparent.png',
              height: 94,
              width: 270,
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
