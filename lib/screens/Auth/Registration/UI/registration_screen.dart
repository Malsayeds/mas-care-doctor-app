import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/auth_cubit.dart';
import 'package:doctoworld_doctor/exceptions/auth_exception.dart';
import 'package:doctoworld_doctor/screens/Auth/Login/UI/login_screen.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/UI/verification_screen.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/utils/keys.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
  final registerFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isHidden = true;
  bool isLoading = false;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter your password'),
    MinLengthValidator(8,
        errorText: 'Password characters must be greater than 8'),
  ]);

  Future<void> registerUser() async {
    final isValid = registerFormKey.currentState?.validate();
    if (isValid ?? false) {
      try {
        setState(() {
          isLoading = true;
        });
        final authData = BlocProvider.of<AuthCubit>(context, listen: false);
        await authData.registerWithEmailAndPasswrod(
          email: _emailController.text,
          password: _passwordController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phone: _phoneController.text,
        );
        Navigator.of(context).pushNamed(VerificationScreen.ROUTE);
        setState(() {
          isLoading = false;
        });
      } on AuthException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        SharedWidgets.showToast(msg: INTERNET_WARNING_MESSAGE);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
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
            key: registerFormKey,
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
                          controller: _firstNameController,
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
                          controller: _lastNameController,
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
                    controller: _phoneController,
                    prefixIcon: Icons.phone,
                    hint: locale.phoneNumber,
                    onValidate: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter Phone Number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  EntryField(
                    controller: _emailController,
                    prefixIcon: Icons.person,
                    hint: locale.emailAddress,
                    onValidate: EmailValidator(
                      errorText: 'Enter a valid email address',
                    ),
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
                    onValidate: passwordValidator,
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
                    onValidate: (val) =>
                        MatchValidator(errorText: 'Passwords don\'t match')
                            .validateMatch(val!, _passwordController.text),
                  ),
                  SizedBox(height: 32.0),
                  CustomButton(
                    onTap: isLoading ? null : registerUser,
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
