import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/utils/shared_widgets.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/Routes/routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const String ROUTE_NAME = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class Availability {
  bool? isChecked;
  String day;

  Availability(this.isChecked, this.day);
}

class _ProfilePageState extends State<ProfilePage> {
  List<Availability> availabilities = [
    Availability(true, 'Mon'),
    Availability(true, 'Tue'),
    Availability(true, 'Wed'),
    Availability(true, 'Thu'),
    Availability(false, 'Fri'),
    Availability(true, 'Sat'),
    Availability(false, 'Sun'),
  ];

  Widget buildChangeImgBottomSheetBody(BuildContext ctx) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  locale.uploadImage.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () async {
                  File? pickedImg =
                      await SharedWidgets.pickImage(ImageType.Camera);
                },
                child: Text('Camera'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: () async {
                  File? pickedImg =
                      await SharedWidgets.pickImage(ImageType.Gallery);
                },
                child: Text('Gallery'),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<String?> services = [
      locale.ser1,
      locale.ser2,
      locale.ser3,
      locale.ser4,
      locale.ser5
    ];
    List<String?> specifications = [
      locale.generalPhysician,
      locale.familyPhysician,
      locale.cardiologist,
      locale.consultant,
      locale.diabetologist
    ];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(locale.myProfile),
          textTheme: Theme.of(context).textTheme,
        ),
        body: FadedSlideAnimation(
          Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FadedScaleAnimation(
                          Image.asset(
                            'assets/doc1.png',
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                          durationInMilliseconds: 400,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            TextButton.icon(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Theme.of(context).primaryColor,
                              ),
                              label: Text(
                                locale.changeImage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(kBorderRadius),
                                      topLeft: Radius.circular(kBorderRadius),
                                    ),
                                  ),
                                  builder: (ctx) {
                                    return buildChangeImgBottomSheetBody(ctx);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        EntryField(
                          prefixIcon: Icons.account_circle,
                          initialValue: 'Dr. Joseph Williamson',
                        ),
                        SizedBox(height: 20),
                        EntryField(
                          prefixIcon: Icons.phone_iphone,
                          initialValue: '+1 987 654 3210',
                        ),
                        SizedBox(height: 20),
                        EntryField(
                          prefixIcon: Icons.mail,
                          initialValue: 'drjoseph@mail.com',
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.servicesAt,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageRoutes.addHospital);
                          },
                          readOnly: true,
                          initialValue: ' Apple Hospital, Wallington, New York',
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.expFees,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          prefixIcon: Icons.library_add_check,
                          initialValue: ' 18 ' + locale.years,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        EntryField(
                          prefixIcon: Icons.account_balance_wallet,
                          initialValue: ' \$28',
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              locale.services,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontSize: 15),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.addService);
                              },
                              child: Text(
                                locale.edit,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  services[index]!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              );
                            }),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+5 ' + locale.more,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              locale.specifications,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontSize: 15),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PageRoutes.addSpecialization);
                              },
                              child: Text(
                                locale.edit,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  specifications[index]!,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              );
                            }),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '+1 ' + locale.more,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Text(
                          locale.availability,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: availabilities.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.only(end: 8, bottom: 6),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: availabilities[index].isChecked,
                                    onChanged: (val) {
                                      setState(() {
                                        availabilities[index].isChecked = val;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    availabilities[index].day,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .disabledColor),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    flex: 5,
                                    child: EntryField(
                                      readOnly: true,
                                      isDense: true,
                                      initialValue: '12:00',
                                      suffixIcon: Icons.arrow_drop_down,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Text(locale.to),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: EntryField(
                                      isDense: true,
                                      readOnly: true,
                                      initialValue: '20:00',
                                      suffixIcon: Icons.arrow_drop_down,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(radius: 0, label: locale.update)),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}