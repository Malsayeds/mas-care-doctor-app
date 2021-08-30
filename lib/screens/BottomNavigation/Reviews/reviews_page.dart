import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/reviews.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewsPage extends StatefulWidget {
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getReviewsData();
  }

  Future<void> getReviewsData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final reviewsData = Provider.of<Reviews>(context, listen: false);
      await reviewsData.getReviews();
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
    final reviewsData = Provider.of<Reviews>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(locale.reviews),
      ),
      body: _isLoading
          ? Center(
              child: SharedWidgets.showLoader(),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FadedScaleAnimation(
                        SharedWidgets.buildImgNetwork(
                          imgUrl:
                              reviewsData.user?.image ?? imagePlaceHolderError,
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: MediaQuery.of(context).size.width / 2.5,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${reviewsData.user?.name ?? ''}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontSize: 22),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              locale.avgReview,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: 12.0),
                            Row(
                              children: [
                                FadedScaleAnimation(
                                  Text(
                                    reviewsData.avgReviews.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Color(0xffF29F19),
                                        ),
                                  ),
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ...reviewsData.rates
                          .map((rate) => buildReviewIndicator(
                                context,
                                rate.rate.toString(),
                                reviewsData.reviews.length == 0
                                    ? 0
                                    : rate.rateCount /
                                        reviewsData.reviews.length,
                                '${rate.rateCount}',
                              ))
                          .toList(),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                locale.totalPeopleRated,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context).disabledColor),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
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
                                      reviewsData.reviews.length.toString(),
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
                                locale.appointmentsBooked,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context).disabledColor),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
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
                                      reviewsData.appointmentsCount.toString(),
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
                  child: Text(
                    locale.recent,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                reviewsData.reviews.length == 0
                    ? SizedBox(
                        height: 75,
                        child: Center(
                          child: Text(locale.noReviewsAvailable),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviewsData.reviews.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      reviewsData.reviews[index].image ??
                                          imagePlaceHolderError),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      reviewsData.reviews[index].username
                                          .substring(
                                        0,
                                        reviewsData.reviews[index].username
                                                    .length >
                                                20
                                            ? 20
                                            : null,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Spacer(),
                                    Text(
                                      reviewsData.reviews[index].rate
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                    SizedBox(width: 5),
                                    Row(
                                      children: List.generate(
                                        reviewsData.reviews[index].rate.floor(),
                                        (index) => Icon(
                                          Icons.star,
                                          size: 12,
                                          color: Color(0xffF29F19),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        5 -
                                            reviewsData.reviews[index].rate
                                                .floor(),
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
                                    Text(
                                      reviewsData.reviews[index].date,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  reviewsData.reviews[index].review,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Divider(thickness: 6),
                            ],
                          );
                        },
                      )
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
