import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookmarksPage extends StatefulWidget {
  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final AppSettings settings = AppSettings(loggedIn: true, darkMode: false);

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

  final Map<String, IconData> industryIcons = {
    'Technology': CupertinoIcons.gear_solid,
    'Healthcare': CupertinoIcons.heart_solid,
    'Financial Services': CupertinoIcons.creditcard,
    'Energy': CupertinoIcons.bolt_horizontal_circle_fill,
    'Consumer Goods': CupertinoIcons.bag_fill,
    'Real Estate': CupertinoIcons.house_fill,
    'Transportation & Logistics': CupertinoIcons.car_detailed,
    'Telecommunications': CupertinoIcons.antenna_radiowaves_left_right,
    'Agriculture & Food Production': CupertinoIcons.leaf_arrow_circlepath,
    'Manufacturing': CupertinoIcons.hammer_fill,
  };

  String? selectedIndustry;
  List<Company> filteredCompanies = [];

  @override
  Widget build(BuildContext context) {
    // Filter the companies based on the selected industry
    filteredCompanies = GlobalState().companies.values.where((company) {
      return selectedIndustry == null ||
          company.industries!.contains(selectedIndustry!);
    }).toList();

    return CupertinoPageScaffold(
      backgroundColor: settings.getBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bookmarks",
              style: TextStyle(
                  color: settings.getPrimaryColor(),
                  fontSize: 28,
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
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
                              .companies[GlobalState().user!.bookmarks[index]]!
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
                    ),
            ),
            Text(
              "Industries",
              style: TextStyle(
                  color: settings.getPrimaryColor(),
                  fontSize: 28,
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 16),
            industryScrollView(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) {
                  Company company = filteredCompanies[index];
                  return Card(
                    child: ListTile(
                      title: Text(company.name!),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SingleFeedPage(
                              company: company,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget industryScrollView() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: industries.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndustry == industries[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    // If already selected, deselect it
                    selectedIndustry = null;
                  } else {
                    // Otherwise, select the clicked industry
                    selectedIndustry = industries[index];
                  }
                });
              },
              child: Column(
                children: [
                  Icon(
                    industryIcons[industries[index]],
                    size: 30,
                    color: isSelected
                        ? settings
                            .getSecondaryColor() // Highlight color for selected industry
                        : settings.getPrimaryColor(),
                  ),
                  Text(
                    industries[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? settings
                              .getSecondaryColor() // Highlight color for selected industry
                          : settings.getPrimaryColor(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
