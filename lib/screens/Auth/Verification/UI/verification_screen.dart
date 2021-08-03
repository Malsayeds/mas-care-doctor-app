import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/utils/Routes/routes.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  static const String ROUTE = 'verificationScreen';
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 20;
  late Timer _timer;

  _startTimer() {
    _counter = 20; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.phoneVerification),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(),
              Text(
                locale.weveSentAnOTP,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).disabledColor),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 2),
              EntryField(
                controller: _controller,
                hint: locale.enter4digitOTP,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              CustomButton(
                onTap: () {
                  Navigator.of(context).pushNamed(PageRoutes.bottomNavigation);
                },
                label: locale.submit,
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$_counter ' + locale.secLeft,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .3,
                    child: CustomButton(
                        label: locale.resend,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        textColor: Theme.of(context).hintColor,
                        padding: 0.0,
                        onTap: _counter < 1
                            ? () {
                                _startTimer();
                              }
                            : null),
                  ),
                ],
              ),
              Spacer(flex: 12),
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
