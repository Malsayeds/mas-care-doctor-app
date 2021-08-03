import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/screens/Auth/Registration/UI/registration_ui.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/entry_field.dart';
import '../../../../Locale/locale.dart';
import '../../../../utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String ROUTE = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColorLight,
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .7,
                  color: theme.backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      //   Spacer(),
                      Image.asset('assets/icons/doctor_logo.png', scale: 3),
                      // Spacer(),
                      Image.asset('assets/hero_image.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .55),
                      EntryField(
                        hint: locale.enterMobileNumber,
                        prefixIcon: Icons.phone_iphone,
                        color: theme.scaffoldBackgroundColor,
                        controller: _numberController,
                      ),
                      SizedBox(height: 20.0),
                      CustomButton(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RegistrationScreen.ROUTE);
                        },
                      ),
                      Spacer(flex: 2),
                      Text(
                        locale.orQuickContinueWith!,
                        style: theme.textTheme.subtitle1,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              icon: Image.asset('assets/icons/ic_fb.png',
                                  scale: 2),
                              color: facebookButtonColor,
                              label: locale.facebook,
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RegistrationScreen.ROUTE);
                              },
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: CustomButton(
                              label: locale.gmail,
                              icon: Image.asset(
                                'assets/icons/ic_ggl.png',
                                scale: 3,
                              ),
                              color: theme.scaffoldBackgroundColor,
                              textColor: theme.hintColor,
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RegistrationScreen.ROUTE);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
