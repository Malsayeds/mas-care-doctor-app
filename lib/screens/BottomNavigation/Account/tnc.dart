import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TnCPage extends StatefulWidget {
  @override
  _TnCPageState createState() => _TnCPageState();
}

class _TnCPageState extends State<TnCPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getTermsAndConditions();
  }

  Future<void> getTermsAndConditions() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final profileData = BlocProvider.of<ProfileCubit>(context, listen: false);
      await profileData.getTermsAndConditions();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      SharedWidgets.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final profileData = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.termsNConditions),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: SharedWidgets.showLoader(),
            )
          : FadedSlideAnimation(
              profileData.termsAndConditionsText.length == 0
                  ? Center(
                      child: Text('No Terms and Conditions Found.'),
                    )
                  : Text(profileData.termsAndConditionsText),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
    );
  }
}
