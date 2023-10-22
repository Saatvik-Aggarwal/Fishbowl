import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/investments.dart';
import 'package:flutter/cupertino.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.settings,
  });

  final AppSettings settings;

  @override
  Onboarding createState() => Onboarding();
}

class Onboarding extends State<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _budget = '';
  List<String> _selectedInterests = [];

  // List of industries
  final List<String> industries = [
    'Technology',
    'Healthcare',
    'Financial Services',
    'Energy',
    'Consumer Goods',
    'Real Estate',
    'Transportation & Logistics',
    'Telecommunications',
    'Agriculture & Food Production',
    'Manufacturing',
  ];

  void _showPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter localSetState) {
          return CupertinoActionSheet(
            title: const Text('Choose your interests'),
            actions: industries.map((industry) {
              return CupertinoActionSheetAction(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(industry),
                    if (_selectedInterests.contains(industry))
                      const Icon(CupertinoIcons.check_mark,
                          color: CupertinoColors.activeBlue)
                  ],
                ),
                onPressed: () {
                  localSetState(() {
                    if (_selectedInterests.contains(industry)) {
                      _selectedInterests.remove(industry);
                    } else {
                      _selectedInterests.add(industry);
                    }
                  });
                },
              );
            }).toList(),
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Done'),
              onPressed: () {
                Navigator.pop(context);
                setState(
                    () {}); // Add this line to update the outer widget's state
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  "First Name",
                  style: TextStyle(
                      color: widget.settings.getPrimaryColor(),
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 8),
                CupertinoTextField(
                  placeholder: 'John',
                  onChanged: (value) {
                    _firstName = value;
                  },
                  onSubmitted: (value) {
                    _firstName = value;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  "Last Name",
                  style: TextStyle(
                      color: widget.settings.getPrimaryColor(),
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 8),
                CupertinoTextField(
                  placeholder: 'Doe',
                  onChanged: (value) {
                    _lastName = value;
                  },
                  onSubmitted: (value) {
                    _lastName = value;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  "What is your budget?",
                  style: TextStyle(
                      color: widget.settings.getPrimaryColor(),
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 8),
                CupertinoTextField(
                  placeholder: '100',
                  onChanged: (value) {
                    _budget = value;
                  },
                  onSubmitted: (value) {
                    _budget = value;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  "Interests",
                  style: TextStyle(
                      color: widget.settings.getPrimaryColor(),
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _showPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.settings.getPrimaryColor(), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(_selectedInterests.join(', ')),
                  ),
                ),
                const SizedBox(height: 82),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: widget.settings.getSecondaryColor()),
                    child: CupertinoButton(
                      child: Text(
                        'Start Swimming',
                        style:
                            TextStyle(color: widget.settings.getPrimaryColor()),
                      ),
                      onPressed: () {
                        print('First Name: $_firstName');
                        print('Last Name: $_lastName');
                        print('Interests: ${_selectedInterests.join(', ')}');
                        print(_budget);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
