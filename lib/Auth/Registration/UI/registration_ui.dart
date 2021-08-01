import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';
import 'registration_interactor.dart';

class RegistrationUI extends StatefulWidget {
  final RegistrationInteractor registrationInteractor;
  final String? phoneNumber;

  RegistrationUI(this.registrationInteractor, this.phoneNumber);

  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {
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
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(),
              Text(
                locale.phoneNumberNotRegistered!,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              EntryField(
                prefixIcon: Icons.phone_iphone,
                hint: locale.mobileNumber,
                initialValue: widget.phoneNumber,
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
                onTap: () => widget.registrationInteractor.register(
                    widget.phoneNumber,
                    _nameController.text,
                    _emailController.text),
              ),
              SizedBox(height: 10.0),
              CustomButton(
                label: locale.backToSignIn,
                color: Theme.of(context).scaffoldBackgroundColor,
                textColor: Theme.of(context).hintColor,
                onTap: widget.registrationInteractor.goBack,
              ),
              Spacer(flex: 5),
              Text(
                locale.wellSendAnOTP!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Spacer(),
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
