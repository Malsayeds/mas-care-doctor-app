import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class Service {
  bool? isChecked;

  Service(this.isChecked);
}

class _AddServiceState extends State<AddService> {
  List<Service> services = [
    Service(true),
    Service(true),
    Service(false),
    Service(false),
    Service(false),
    Service(true),
    Service(true),
    Service(false),
    Service(true),
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<String?> serviceTitle = [
      locale.ser1,
      locale.ser2,
      locale.ser3,
      locale.ser4,
      locale.ser5,
      locale.ser6,
      locale.ser7,
      locale.ser8,
      locale.ser9,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.addService!),
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
                    hint: locale.searchService,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: Theme.of(context).dividerColor,
                  child: Text(
                    locale.selectServiceToAdd!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
                ListView.builder(
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
                              services[index].isChecked = val;
                            });
                          },
                        ),
                        title: Text(serviceTitle[index]!),
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
