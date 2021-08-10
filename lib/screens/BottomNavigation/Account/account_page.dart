import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/auth_cubit.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/change_language_page.dart';
import 'package:doctoworld_doctor/screens/BottomNavigation/Account/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<MenuTile> _menu = [
      MenuTile(
        locale.myProfile,
        locale.letUsHelpYou,
        Icons.store,
        () {
          Navigator.pushNamed(context, ProfilePage.ROUTE_NAME);
        },
      ),
      MenuTile(
        locale.changeLanguage,
        locale.changeLanguage,
        Icons.language,
        () {
          Navigator.pushNamed(context, ChangeLanguagePage.ROUTE_NAME);
        },
      ),
      MenuTile(
        locale.contactUs,
        locale.letUsHelpYou,
        Icons.mail,
        () {
          Navigator.pushNamed(context, PageRoutes.supportPage);
        },
      ),
      MenuTile(
        locale.tnC,
        locale.companyPolicies,
        Icons.assignment,
        () {
          Navigator.pushNamed(context, PageRoutes.tncPage);
        },
      ),
      MenuTile(
        locale.faqs,
        locale.quickAnswers,
        Icons.announcement,
        () {
          Navigator.pushNamed(context, PageRoutes.faqPage);
        },
      ),
      MenuTile(
        locale.logout,
        locale.seeYouSoon,
        Icons.exit_to_app,
        () async {
          final authData = BlocProvider.of<AuthCubit>(context, listen: false);
          await authData.logout();
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.account),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                FadedScaleAnimation(
                  Image.asset(
                    'assets/doc1.png',
                    width: MediaQuery.of(context).size.width / 2.5,
                  ),
                  durationInMilliseconds: 400,
                ),
                SizedBox(width: 16),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Dr.\n' + 'Joseph\nWilliamson\n\n',
                      style: Theme.of(context).textTheme.headline5),
                  TextSpan(
                      text: '+1 987 654 3210',
                      style: Theme.of(context).textTheme.subtitle2),
                ]))
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight,
            child: GridView.builder(
                itemCount: _menu.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.7, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _menu[index].onTap as void Function()?,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FadedScaleAnimation(
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              child: Text(
                                _menu[index].title!,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            durationInMilliseconds: 400,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                child: Text(
                                  _menu[index].subtitle!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                _menu[index].iconData,
                                size: 32,
                                color: Theme.of(context).primaryColorLight,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
