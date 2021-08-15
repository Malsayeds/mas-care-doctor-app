import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:doctoworld_doctor/utils/keys.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/Theme/colors.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final contactSupportFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool _isLoading = false;

  Future<void> _sendSupportMessage() async {
    try {
      final isValid = contactSupportFormKey.currentState?.validate();
      if (isValid ?? false) {
        setState(() {
          _isLoading = true;
        });
        final profileData =
            BlocProvider.of<ProfileCubit>(context, listen: false);
        await profileData.sendSupportMessage(
          email: emailController.text,
          message: messageController.text,
        );
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is SupportMessageSentState) {
          setState(() {
            emailController.text = '';
            messageController.text = '';
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.support),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: FadedSlideAnimation(
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Form(
                key: contactSupportFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      locale.howMayWeHelpYou,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: textColor),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      locale.letUsKnowUrQueriesFeedbacks,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(height: 12.0),
                    EntryField(
                      controller: emailController,
                      prefixIcon: Icons.mail,
                      hint: locale.emailAddress,
                      onValidate: EmailValidator(
                        errorText: 'Enter a valid email address',
                      ),
                    ),
                    SizedBox(height: 12.0),
                    EntryField(
                      controller: messageController,
                      prefixIcon: Icons.edit,
                      hint: locale.writeYourMsg,
                      maxLines: 4,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter your message';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    CustomButton(
                      label: locale.submit,
                      onTap: _isLoading ? null : _sendSupportMessage,
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: FadedScaleAnimation(
                        Image.asset('assets/hero_image.png'),
                        durationInMilliseconds: 400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
