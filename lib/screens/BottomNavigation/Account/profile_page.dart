import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/cubit/profile_cubit.dart';
import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/entry_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/Routes/routes.dart';
import 'package:flutter/material.dart';
import "package:doctoworld_doctor/utils/extensions.dart";

class ProfilePage extends StatefulWidget {
  static const String ROUTE_NAME = 'profile_page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildTimeSlotButton({
    required bool isFrom,
    required Availability availabilityItem,
    required int index,
  }) {
    final d = BlocProvider.of<ProfileCubit>(context);
    return Expanded(
      flex: 5,
      child: InkWell(
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.schedule,
                    color: primaryColor,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      isFrom
                          ? availabilityItem.from.format(context)
                          : availabilityItem.to.format(context),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              primary: Theme.of(context).primaryColorLight,
              elevation: 0,
            ),
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime:
                    isFrom ? availabilityItem.from : availabilityItem.to,
              );
              if (pickedTime != null) {
                print(pickedTime.format(context));
                print(isFrom);

                if (isFrom) {
                  d.setFromDate(index, pickedTime);
                } else {
                  d.setToDate(index, pickedTime);
                }
              }
            },
          ),
        ),
      ),
    );
  }

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
                child: Text(locale.camera),
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
                child: Text(locale.gallery),
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

  TextButton buildTextButton({
    required String text,
    required VoidCallback onPress,
  }) {
    return TextButton(
      onPressed: onPress,
      child: Text(text.toUpperCase()),
      style: TextButton.styleFrom(
        primary: primaryColor,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final profileData = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(locale.myProfile),
        textTheme: Theme.of(context).textTheme,
      ),
      body: FadedSlideAnimation(
        ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FadedScaleAnimation(
                    SharedWidgets.buildImgNetwork(
                      imgUrl: profileData.profile.imgUrl,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
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
                              .copyWith(color: Theme.of(context).primaryColor),
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
                  Row(
                    children: [
                      Text(
                        'Personal Information',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.update,
                        onPress: () {},
                      ),
                    ],
                  ),
                  EntryField(
                    prefixIcon: Icons.account_circle,
                    initialValue: profileData.profile.name,
                    hint: 'Enter your Name',
                  ),
                  SizedBox(height: 20),
                  EntryField(
                    prefixIcon: Icons.phone_iphone,
                    initialValue: profileData.profile.phoneNumber,
                    hint: 'Enter your Phone Number',
                  ),
                  SizedBox(height: 20),
                  EntryField(
                    prefixIcon: Icons.mail,
                    initialValue: profileData.profile.mail,
                    hint: 'Enter your Email Address',
                  ),
                ],
              ),
            ),
            Divider(thickness: 6),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        locale.servicesAt,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.update,
                        onPress: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.addHospital);
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
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.expFees,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 15,
                            ),
                      ),
                      buildTextButton(
                        text: locale.update,
                        onPress: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    prefixIcon: Icons.work,
                    initialValue: '${profileData.profile.experience.toInt()} ' +
                        locale.years,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EntryField(
                    prefixIcon: Icons.paid,
                    initialValue: '${profileData.profile.fees.toInt()}',
                  ),
                ],
              ),
            ),
            Divider(thickness: 6),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        locale.services,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 15),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.edit,
                        onPress: () {
                          Navigator.pushNamed(
                              context, PageRoutes.addSpecialization);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: profileData.services.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            profileData.services[index].title,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${profileData.services.length - 2} ' + locale.more,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        locale.specifications,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 15),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.edit,
                        onPress: () {
                          Navigator.pushNamed(
                              context, PageRoutes.addSpecialization);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: profileData.services.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          profileData.specifications[index].title,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '+${profileData.services.length - 2} ' + locale.more,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        locale.availability,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 15,
                            ),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.update,
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profileData.availabilities.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final availabilityItem = profileData.availabilities[index];
                    return BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: 8, bottom: 6),
                          child: Row(
                            children: [
                              Checkbox(
                                value:
                                    profileData.availabilities[index].isChecked,
                                onChanged: (val) {
                                  if (val != null) {
                                    profileData.setDayCheck(index, val);
                                  }
                                },
                                activeColor: Theme.of(context).primaryColor,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  availabilityItem.day.capitalize(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Theme.of(context).disabledColor,
                                      ),
                                ),
                              ),
                              _buildTimeSlotButton(
                                isFrom: true,
                                availabilityItem: availabilityItem,
                                index: index,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(locale.to),
                              ),
                              _buildTimeSlotButton(
                                isFrom: false,
                                availabilityItem: availabilityItem,
                                index: index,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 16,
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
