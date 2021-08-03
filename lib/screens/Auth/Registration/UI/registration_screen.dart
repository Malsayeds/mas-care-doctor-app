import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/UI/verification_screen.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/entry_field.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String ROUTE = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.registerNow!),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  locale.phoneNumberNotRegistered!,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                EntryField(
                  prefixIcon: Icons.phone_iphone,
                  hint: locale.mobileNumber,
                  readOnly: true,
                ),
                SizedBox(height: 20.0),
                EntryField(
                  controller: _nameController,
                  prefixIcon: Icons.person,
                  hint: locale.fullName,
                ),
                SizedBox(height: 20.0),
                EntryField(
                  controller: _emailController,
                  prefixIcon: Icons.mail,
                  hint: locale.emailAddress,
                ),
                SizedBox(height: 20.0),
                CustomButton(
                  onTap: () {
                    Navigator.of(context).pushNamed(VerificationScreen.ROUTE);
                  },
                ),
                SizedBox(height: 10.0),
                CustomButton(
                  label: locale.backToSignIn,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  textColor: Theme.of(context).hintColor,
                  onTap: () {
                    Navigator.of(context).pushNamed(VerificationScreen.ROUTE);
                  },
                ),
                Text(
                  locale.wellSendAnOTP!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
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
