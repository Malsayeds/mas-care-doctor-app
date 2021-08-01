import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_interactor.dart';

class LoginUI extends StatefulWidget {
  final LoginInteractor loginInteractor;

  LoginUI(this.loginInteractor);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
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
                  height: size.height * 0.65,
                  color: theme.backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Spacer(),
                      Image.asset('assets/icons/doctor_logo.png', scale: 3),
                      Spacer(),
                      Image.asset('assets/hero_image.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.595),
                      EntryField(
                        hint: locale.enterMobileNumber,
                        prefixIcon: Icons.phone_iphone,
                        color: theme.scaffoldBackgroundColor,
                        controller: _numberController,
                      ),
                      SizedBox(height: 20.0),
                      CustomButton(
                          onTap: () => widget.loginInteractor
                              .loginWithMobile('', _numberController.text)),
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
                              onTap: () =>
                                  widget.loginInteractor.loginWithFacebook(),
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
                              onTap: () =>
                                  widget.loginInteractor.loginWithGoogle(),
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
