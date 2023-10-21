import 'package:fishbowl/appsettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final settings = AppSettings(loggedIn: true, darkMode: false);

  bool _requesting = false;

  Future<void> _login() async {
    if (_requesting) {
      return;
    }

    setState(() {
      _requesting = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      // ignore: empty_catches
    } catch (e) {
      Toast.show(
        (e is FirebaseAuthException)
            ? e.message ?? 'Unknown error'
            : "Unknown error",
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
    }

    setState(() {
      _requesting = false;
    });
  }

  Future<void> _signup() async {
    if (_requesting) {
      return;
    }

    setState(() {
      _requesting = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      Toast.show(
        (e is FirebaseAuthException)
            ? e.message ?? 'Unknown error'
            : "Unknown error",
        duration: Toast.lengthShort,
        gravity: Toast.bottom,
      );
    }

    setState(() {
      _requesting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: settings.getBackgroundColor(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/png/logo-white-transparent.png',
                  height: 64,
                  width: 200,
                ),
                const SizedBox(height: 32.0),
                CupertinoTextField(
                  controller: _emailController,
                ),
                const SizedBox(height: 16.0),
                CupertinoTextField(
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _signup();
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(width: 16.0),
                    CupertinoButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _login();
                        }
                      },
                      child: const Text(
                        'Login',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
