import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishbowl/appsettings.dart';
import 'package:fishbowl/feed.dart';
import 'package:fishbowl/globalstate.dart';
import 'package:fishbowl/obj/company.dart';
import 'package:flutter/cupertino.dart';
import 'package:openai_client/openai_client.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Company> companies = [];
  String? completionText; // To hold the text returned by OpenAI
  List? user_preferences_list = GlobalState().user?.industries;
  Map<Company, List?> startups_and_industries_map = {};

  @override
  void initState() {
    super.initState();

    // Get all the companies in the /companies collection
    print("user preferences got it $user_preferences_list");

    FirebaseFirestore.instance
        .collection('companies')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        companies.add(Company.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        ));
      }

      setState(() {
        companies = companies;
        // print companies
        for (var company in companies) {
          startups_and_industries_map[company] = company.industries;
          print(company);
        }

<<<<<<< Updated upstream
        GlobalState().currentVideoCompanyId.value = companies[0].id!;
=======
        print("startups and industries are $startups_and_industries_map");
>>>>>>> Stashed changes
      });
    });

    fetchOpenAICompletion();
  }

  // Moved the asynchronous code to a separate method
  Future<void> fetchOpenAICompletion() async {
    print("OPENAI WORKS");
    const conf = OpenAIConfiguration(
      apiKey: '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',
    );
    final client = OpenAIClient(configuration: conf);
    final completion = await client.completions
        .create(
          temperature: 1,
          maxTokens: 150,
          model: 'text-davinci-003',
          prompt: promptGen(),
        )
        .data;
    completionText = "${completion.choices[0].text.trim()}\n\n";
    print(completionText);
    setState(() {});
  }

  promptGen() {
    print(
        "Given a user's preferences in industries and a list of start-ups along with their respective industries, rank the start-ups in order of relevance to the user's preferences. User's preferences: $user_preferences_list. Start-ups and their industries: $startups_and_industries_map. Original order of start-ups: $companies. Return an array of indices in the order the start-ups should be presented to the user.");
    return "Given a user's preferences in industries and a list of start-ups along with their respective industries, rank the start-ups in order of relevance to the user's preferences. User's preferences: $user_preferences_list. Start-ups and their industries: $startups_and_industries_map. Original order of start-ups: $companies. Return an array of indices in the order the start-ups should be presented to the user.";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppSettings().getPrimaryColor(),
        child: companies.isEmpty
            ? const Center(child: CupertinoActivityIndicator())
            : SwipableStack(
                allowVerticalSwipe: false,
                onSwipeCompleted: (index, direction) {
                  GlobalState().currentVideoCompanyId.value =
                      companies[(index + 1) % companies.length].id!;
                },
                builder: (context, properties) {
                  return SingleFeedPage(
                      company: companies[properties.index % companies.length]);
                }));
  }
}
