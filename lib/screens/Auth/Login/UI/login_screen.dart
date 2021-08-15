import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/auth_cubit.dart';
import 'package:doctoworld_doctor/exceptions/auth_exception.dart';
import 'package:doctoworld_doctor/screens/Auth/Registration/UI/registration_screen.dart';
import 'package:doctoworld_doctor/utils/Routes/routes.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/utils/keys.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../utils/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  static const String ROUTE = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isHidden = true;
  bool isLoading = false;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Enter your password'),
    MinLengthValidator(
      8,
      errorText: 'Password characters must be greater than 8',
    ),
  ]);

  Future<void> loginUser() async {
    final isValid = loginFormKey.currentState?.validate();
    if (isValid ?? false) {
      try {
        setState(() {
          isLoading = true;
        });
        final authData = BlocProvider.of<AuthCubit>(context, listen: false);
        await authData.loginWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.of(context).pushNamed(PageRoutes.bottomNavigation);
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
        SharedWidgets.showToast(msg: e.toString());
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
        Container(
          color: theme.backgroundColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                height: size.height,
                color: theme.backgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/icons/doctor_logo.png',
                        height: size.height * 0.3,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        'assets/hero_image.png',
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.325,
                        ),
                        EntryField(
                          hint: locale.emailAddress,
                          prefixIcon: Icons.phone_iphone,
                          color: theme.scaffoldBackgroundColor,
                          controller: _emailController,
                          onValidate: EmailValidator(
                            errorText: 'Enter a valid email address',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        EntryField(
                          controller: _passwordController,
                          hint: locale.password,
                          prefixIcon: Icons.lock,
                          isHidden: isHidden,
                          suffixIcon: !isHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixOnTap: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          color: theme.scaffoldBackgroundColor,
                          onValidate: passwordValidator,
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        CustomButton(
                          onTap: isLoading ? null : loginUser,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.white.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        RegistrationScreen.ROUTE);
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Don\'t have an account?',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Sign Up',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  locale.or,
                                  style: theme.textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  locale.orQuickContinueWith,
                                  style: theme.textTheme.subtitle1?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
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
                                      .pushNamed(PageRoutes.bottomNavigation);
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
                                      .pushNamed(PageRoutes.bottomNavigation);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
