import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewDetail {
  String image;
  String name;
  String? disease;
  double rating;
  String date;

  ReviewDetail(this.image, this.name, this.disease, this.rating, this.date);
}

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<ReviewDetail> _reviews = [
      ReviewDetail('assets/doctors/Curves 1509.png', 'Ronny George',
          locale.coldFever, 5.0, '20 Dec, 2019'),
      ReviewDetail('assets/doctors/Curves 1514.png', 'Reena Roy',
          locale.headache, 4.0, '15 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1314 copy.png', 'Herry Johnson',
          locale.headache, 1.0, '02 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1499.png', 'Ronny George',
          locale.coldFever, 5.0, '20 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1504.png', 'Reena Roy',
          locale.headache, 4.0, '15 Dec, 2019'),
      ReviewDetail('assets/doctors/Curves 1509.png', 'Ronny George',
          locale.coldFever, 5.0, '20 Dec, 2019'),
      ReviewDetail('assets/doctors/Curves 1514.png', 'Reena Roy',
          locale.headache, 4.0, '15 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1314 copy.png', 'Herry Johnson',
          locale.headache, 1.0, '02 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1499.png', 'Ronny George',
          locale.coldFever, 5.0, '20 Dec, 2019'),
      ReviewDetail('assets/doctors/Layer 1504.png', 'Reena Roy',
          locale.headache, 4.0, '15 Dec, 2019'),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(locale.reviews!),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FadedScaleAnimation(
                  Image.asset(
                    'assets/doc1.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                  durationInMilliseconds: 400,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr.\n' + 'Joseph\nWilliamson',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 22)),
                    SizedBox(height: 12.0),
                    Text(locale.avgReview!,
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        FadedScaleAnimation(
                          Text('4.5'.padRight(5),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Color(0xffF29F19))),
                          durationInMilliseconds: 400,
                        ),
                        FadedScaleAnimation(
                          Icon(
                            Icons.star,
                            size: 36,
                            color: Color(0xffF29F19),
                          ),
                          durationInMilliseconds: 400,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                buildReviewIndicator(context, '5', 0.8, '78'),
                buildReviewIndicator(context, '4', 0.6, '24'),
                buildReviewIndicator(context, '3', 0.1, ' 8 '),
                buildReviewIndicator(context, '2', 0.2, '11'),
                buildReviewIndicator(context, '1', 0.1, ' 3 '),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          locale.totalPeopleRated!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.perm_contact_cal,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '78',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          locale.appointmentsBooked!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Theme.of(context).disabledColor),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Theme.of(context).primaryColor,
                                size: 18,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '129',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Theme.of(context).primaryColorLight,
            child: Text(locale.recent!,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _reviews.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(_reviews[index].image),
                      ),
                      title: Row(
                        children: [
                          Text(
                            _reviews[index].name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Spacer(),
                          Text(
                            _reviews[index].rating.toString(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                          SizedBox(width: 5),
                          Row(
                            children: List.generate(
                              _reviews[index].rating.floor(),
                              (index) => Icon(
                                Icons.star,
                                size: 12,
                                color: Color(0xffF29F19),
                              ),
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5 - _reviews[index].rating.floor(),
                              (index) => Icon(
                                Icons.star,
                                size: 12,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: locale.forr! + ' ',
                                style: Theme.of(context).textTheme.caption),
                            TextSpan(
                              text: locale.coldFever,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: textColor),
                            ),
                          ])),
                          Spacer(),
                          Text(
                            '20 Dec, 2020',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                    ),
                    Divider(thickness: 6),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget buildReviewIndicator(
      context, String number, double percent, String reviews) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FadedScaleAnimation(
        LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(color: textColor),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.star,
                color: starColor,
                size: 20,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          trailing: Text(
            reviews,
            style: TextStyle(color: textColor),
          ),
          backgroundColor: Theme.of(context).dividerColor,
          width: 240.0,
          lineHeight: 10.0,
          percent: percent,
          progressColor: Theme.of(context).primaryColor,
        ),
        durationInMilliseconds: 400,
      ),
    );
  }
}
