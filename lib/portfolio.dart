import 'package:fishbowl/appsettings.dart';
import 'package:flutter/cupertino.dart';

class Portfolio extends StatelessWidget {
  AppSettings settings;

  Portfolio({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        backgroundColor: settings.getBackgroundColor(),
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}
