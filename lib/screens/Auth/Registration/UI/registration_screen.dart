import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/UI/verification_screen.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/keys.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String ROUTE = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.registerNow),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Form(
            key: Keys.registerFormKey,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    locale.phoneNumberNotRegistered,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: EntryField(
                          controller: _passwordController,
                          hint: 'First Name',
                          onValidate: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Enter First Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: EntryField(
                          controller: _passwordController,
                          hint: 'Last Name',
                          onValidate: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Enter Last Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  EntryField(
                    controller: _emailController,
                    prefixIcon: Icons.person,
                    hint: locale.emailAddress,
                    onValidate: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Email Address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  EntryField(
                    controller: _passwordController,
                    prefixIcon: Icons.lock,
                    hint: locale.password,
                    isHidden: isHidden,
                    suffixIcon:
                        !isHidden ? Icons.visibility : Icons.visibility_off,
                    suffixOnTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    onValidate: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Password';
                      } else if (text.length < 8) {
                        return 'Password characters must be greater than 8';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  EntryField(
                    prefixIcon: Icons.lock,
                    hint: locale.confirmPassword,
                    isHidden: isHidden,
                    suffixIcon:
                        !isHidden ? Icons.visibility : Icons.visibility_off,
                    suffixOnTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    onValidate: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter password confirmation';
                      } else if (text.length < 8) {
                        return 'Password characters must be greater than 8';
                      } else if (text != _passwordController.text) {
                        return 'Password doesn\'t match';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 32.0),
                  CustomButton(
                    onTap: () {
                      final isValid =
                          Keys.registerFormKey.currentState?.validate();
                      Navigator.of(context).pushNamed(VerificationScreen.ROUTE);
                    },
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.ROUTE);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' Sign In',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    locale.wellSendAnOTP,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
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
