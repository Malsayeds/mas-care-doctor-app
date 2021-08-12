import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  @override
  Widget build(BuildContext context) {
    final profileData = BlocProvider.of<ProfileCubit>(context);
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.addHospital),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12),
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
                ListView.separated(
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
                            profileData.hospitals[index].isChecked =
                                val ?? false;
                          });
                        },
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        title: Text(profileData.hospitals[index].title),
                        subtitle:
                            Text(profileData.hospitals[index].subtitle),
                      );
                    }),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                label: locale.save,
                radius: 0,
              ),
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
