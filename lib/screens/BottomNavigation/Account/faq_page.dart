import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/profile.dart';
import 'package:doctoworld_doctor/models/faq_question.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  bool _isLoading = false;
  List<double> _isActive = [
    0,
    70,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  Future<void> getQuestions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.getFAQs();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final profileData = Provider.of<Profile>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.faq),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: SharedWidgets.showLoader(),
            )
          : FadedSlideAnimation(
              profileData.faqs.length == 0
                  ? Center(
                      child: Text('No FAQs Found.'),
                    )
                  : ListView.builder(
                      itemCount: profileData.faqs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isActive[index] =
                                      _isActive[index] == 0 ? 70 : 0;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Text(
                                  (index + 1).toString() +
                                      '. ' +
                                      profileData.faqs[index].question,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding:
                                  EdgeInsets.only(left: 34, right: 34, top: 4),
                              height: _isActive[index],
                              child: Text(
                                profileData.faqs[index].answer,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Divider(thickness: 4),
                          ],
                        );
                      },
                    ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
    );
  }
}
