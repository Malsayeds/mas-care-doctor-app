import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/profile.dart';
import 'package:doctoworld_doctor/models/service.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  bool isLoading = false;
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        setState(() {
          services =
              ModalRoute.of(context)?.settings.arguments as List<Service>;
        });
      },
    );
  }

  Future<void> updateServices() async {
    try {
      setState(() {
        isLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.updateServices(services: this.services);
      SharedWidgets.showToast(msg: 'Services Updated Successfully');
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
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.addService),
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
                hint: locale.searchService,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Theme.of(context).dividerColor,
              child: Text(
                locale.selectServiceToAdd,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).disabledColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12),
                itemCount: services.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                    leading: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: services[index].isChecked,
                      onChanged: (val) {
                        setState(() {
                          services[index].isChecked = val ?? false;
                        });
                      },
                    ),
                    title: Text(services[index].name),
                  );
                },
              ),
            ),
            CustomButton(
              onTap: isLoading ? null : updateServices,
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
