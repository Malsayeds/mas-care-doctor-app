import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/profile.dart';
import 'package:doctoworld_doctor/models/hospital.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  bool isLoading = false;
  List<Hospital> hospitals = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        setState(() {
          hospitals =
              ModalRoute.of(context)?.settings.arguments as List<Hospital>;
        });
      },
    );
  }

  Future<void> updateHospitals() async {
    try {
      setState(() {
        isLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.updateHospitals(hospitals: this.hospitals);
      SharedWidgets.showToast(msg: 'Hospitals Updated Successfully');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      SharedWidgets.showToast(msg: INTERNET_WARNING_MESSAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<Profile>(context);
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.addHospital),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: EntryField(
                prefixIcon: Icons.search,
                hint: locale.searchHospital,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Theme.of(context).dividerColor,
              child: Text(
                locale.selectHospitalsToAdd,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: profileData.hospitals.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, i) {
                  return Divider(
                    thickness: 6,
                  );
                },
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: profileData.hospitals[index].isChecked,
                    onChanged: (val) {
                      setState(() {
                        profileData.hospitals[index].isChecked = val ?? false;
                      });
                    },
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    title: Text(profileData.hospitals[index].name),
                    // subtitle: Text(profileData.hospitals[index].subtitle),
                  );
                },
              ),
            ),
            CustomButton(
              onTap: updateHospitals,
              label: locale.save,
              radius: 0,
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
