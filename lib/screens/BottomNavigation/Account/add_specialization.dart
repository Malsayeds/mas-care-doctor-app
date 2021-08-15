import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:doctoworld_doctor/models/specialization.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddSpecialization extends StatefulWidget {
  @override
  _AddSpecializationState createState() => _AddSpecializationState();
}

class _AddSpecializationState extends State<AddSpecialization> {
  List<Specialization> specializations = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        setState(() {
          specializations = ModalRoute.of(context)?.settings.arguments
              as List<Specialization>;
        });
      },
    );
  }

  Future<void> updateSpecializations() async {
    try {
      final profileData = BlocProvider.of<ProfileCubit>(context, listen: false);
      await profileData.updateSpecializations(
          specializations: this.specializations);
      SharedWidgets.showToast(msg: 'Specializations Updated Successfully');
      Navigator.of(context).pop();
    } catch (e) {
      SharedWidgets.showToast(msg: INTERNET_WARNING_MESSAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.addSpecialization),
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
                hint: locale.searchSpecialization,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Theme.of(context).dividerColor,
              child: Text(
                locale.selectSpecializationToAdd,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12),
                itemCount: specializations.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                    leading: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: specializations[index].isChecked,
                      onChanged: (val) {
                        setState(() {
                          specializations[index].isChecked = val ?? false;
                        });
                      },
                    ),
                    title: Text(specializations[index].name),
                  );
                },
              ),
            ),
            CustomButton(
              onTap: updateSpecializations,
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
