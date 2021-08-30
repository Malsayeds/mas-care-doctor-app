import 'dart:io';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/providers/profile.dart';
import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/models/availability.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
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
  final _personalInfoFormKey = GlobalKey<FormState>();
  final _expAndFeesFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _aboutController = TextEditingController();

  final _feesController = TextEditingController();
  final _bioController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _consultationController = TextEditingController();

  bool isPersonalInfoLoading = false;
  bool isExpAndFeesLoading = false;
  bool isAvailabilityLoading = false;

  late bool canApproveCoupon;
  late bool canCheckupHome;

  static const double sizedBoxHeight = 10.0;

  @override
  void initState() {
    super.initState();
    final profileData = Provider.of<Profile>(context, listen: false);
    _nameController.text = '${profileData.user?.name ?? ''}';
    _titleController.text = '${profileData.user?.title ?? ''}';
    _phoneController.text = profileData.user?.phone ?? '';
    _mailController.text = profileData.user?.email ?? '';
    _aboutController.text = profileData.user?.about ?? '';
    _addressController.text = profileData.user?.address ?? '';
    _feesController.text = '${profileData.user?.fees}';
    _bioController.text = '${profileData.user?.bio}';
    _qualificationController.text = '${profileData.user?.qualification}';
    _consultationController.text = '${profileData.user?.consultationFees}';
    canApproveCoupon = profileData.user?.canApproveCoupon == 1;
    canCheckupHome = profileData.user?.canCheckupHome == 1;
  }

  Future<void> updatePersonalInfo() async {
    FocusScope.of(context).unfocus();
    final isValid = _personalInfoFormKey.currentState?.validate();
    if (isValid ?? false) {
      setState(() {
        isPersonalInfoLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.updatePersonalInfo(
        name: _nameController.text,
        phone: _phoneController.text,
        email: _mailController.text,
        title: _titleController.text,
        qualification: _qualificationController.text,
        bio: _bioController.text,
        address: _addressController.text,
        about: _aboutController.text,
      );
      setState(() {
        isPersonalInfoLoading = false;
      });
    }
  }

  Future<void> updateExpAndFees() async {
    FocusScope.of(context).unfocus();
    final isValid = _expAndFeesFormKey.currentState?.validate();
    if (isValid ?? false) {
      setState(() {
        isExpAndFeesLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.updateExperienceAndFees(
        fees: _feesController.text,
        consFees: _consultationController.text,
        canApproveCoupons: canApproveCoupon,
        canCheckUpHome: canCheckupHome,
      );
      setState(() {
        isExpAndFeesLoading = false;
      });
    }
  }

  Future<void> changeProfilePic(File img) async {
    try {
      FocusScope.of(context).unfocus();
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.changeProfilePic(img);
    } catch (e) {}
  }

  Widget _buildTimeSlotButton({
    required bool isFrom,
    required Availability availabilityItem,
    required int index,
  }) {
    final d = Provider.of<Profile>(context);
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
                  if (pickedImg != null) {
                    await changeProfilePic(pickedImg);
                  }
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
                  if (pickedImg != null) {
                    await changeProfilePic(pickedImg);
                  }
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

  Future<void> updateAvailability() async {
    try {
      setState(() {
        isAvailabilityLoading = true;
      });
      final profileData = Provider.of<Profile>(context, listen: false);
      await profileData.updateAvailabilities();
      SharedWidgets.showToast(msg: 'Availabilities Updated Successfully');
      setState(() {
        isAvailabilityLoading = false;
      });
    } catch (e) {
      setState(() {
        isAvailabilityLoading = false;
      });
      SharedWidgets.showToast(msg: INTERNET_WARNING_MESSAGE);
    }
  }

  TextButton buildTextButton({
    required String text,
    required VoidCallback? onPress,
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _titleController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _mailController.dispose();
    _feesController.dispose();
    _bioController.dispose();
    _qualificationController.dispose();
    _consultationController.dispose();
    _addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final profileData = Provider.of<Profile>(context);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadedScaleAnimation(
                    SharedWidgets.buildImgNetwork(
                      imgUrl:
                      profileData.user?.image ?? imagePlaceHolderError,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.width / 2.5,
                    ),
                    durationInMilliseconds: 400,
                  ),
                  // SizedBox(width: 20),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(height: 16),
                  //     TextButton.icon(
                  //       icon: Icon(
                  //         Icons.camera_alt,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //       label: Text(
                  //         locale.changeImage,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyText2!
                  //             .copyWith(
                  //                 color: Theme.of(context).primaryColor),
                  //       ),
                  //       onPressed: () {
                  //         showModalBottomSheet(
                  //           context: context,
                  //           isScrollControlled: true,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(
                  //               topRight: Radius.circular(kBorderRadius),
                  //               topLeft: Radius.circular(kBorderRadius),
                  //             ),
                  //           ),
                  //           builder: (ctx) {
                  //             return buildChangeImgBottomSheetBody(ctx);
                  //           },
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Divider(
              thickness: 8,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _personalInfoFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Personal Information',
                          style:
                          Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        buildTextButton(
                          text: locale.update,
                          onPress: isPersonalInfoLoading
                              ? null
                              : updatePersonalInfo,
                        ),
                      ],
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _titleController,
                      prefixIcon: Icons.account_circle,
                      hint: 'Enter your Title',
                      label: 'Title',
                      textInputType: TextInputType.name,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Title can\'t be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _nameController,
                      prefixIcon: Icons.account_circle,
                      hint: 'Enter your Name',
                      label: locale.fullName,
                      textInputType: TextInputType.name,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Name can\'t be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _phoneController,
                      prefixIcon: Icons.phone_iphone,
                      hint: 'Enter your Phone Number',
                      label: locale.phoneNumber,
                      textInputType: TextInputType.phone,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Phone can\'t be empty';
                        } else if (text.length != 11) {
                          return 'Enter a valid phone number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _mailController,
                      prefixIcon: Icons.mail,
                      hint: 'Enter your Email Address',
                      label: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      onValidate: EmailValidator(
                        errorText: 'Enter a valid email address',
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _addressController,
                      prefixIcon: Icons.info,
                      hint: 'Enter your Address',
                      label: 'Address',
                      textInputType: TextInputType.text,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Address can\'t be empty';
                        }
                      },
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _bioController,
                      prefixIcon: Icons.info,
                      hint: 'Enter your Bio',
                      label: 'Bio',
                      textInputType: TextInputType.text,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Bio can\'t be empty';
                        }
                      },
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _qualificationController,
                      prefixIcon: Icons.info,
                      hint: 'Enter your Qualifications',
                      label: 'Qualifications',
                      textInputType: TextInputType.text,
                      maxLines: 4,
                    ),
                    SizedBox(height: sizedBoxHeight),
                    EntryField(
                      controller: _aboutController,
                      prefixIcon: Icons.info,
                      hint: 'Enter your About',
                      label: 'About',
                      textInputType: TextInputType.text,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'About can\'t be empty';
                        }
                      },
                    ),
                  ],
                ),
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
              child: Form(
                key: _expAndFeesFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.expFees,
                          style:
                          Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 15,
                          ),
                        ),
                        buildTextButton(
                          text: locale.update,
                          onPress:
                          isExpAndFeesLoading ? null : updateExpAndFees,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      controller: _feesController,
                      label: 'Fees',
                      hint: 'Enter your Fees',
                      textInputType: TextInputType.number,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Fees can\'t be empty';
                        } else if (double.tryParse(text) == null) {
                          return 'Enter a valid number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    EntryField(
                      controller: _consultationController,
                      label: 'Consultation',
                      hint: 'Enter your Consultation Fees',
                      textInputType: TextInputType.number,
                      onValidate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Consultation Fees can\'t be empty';
                        } else if (double.tryParse(text) == null) {
                          return 'Enter a valid number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    SwitchListTile.adaptive(
                      value: canApproveCoupon,
                      tileColor: Theme.of(context).primaryColorLight,
                      title: Text('Approve Coupons'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      onChanged: (value) {
                        setState(() {
                          canApproveCoupon = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: sizedBoxHeight,
                    ),
                    SwitchListTile.adaptive(
                      value: canCheckupHome,
                      tileColor: Theme.of(context).primaryColorLight,
                      title: Text('Checkup In-Home'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      onChanged: (value) {
                        setState(() {
                          canCheckupHome = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(thickness: 6),
            Card(
              margin: const EdgeInsets.all(0),
              elevation: 0,
              child: InkWell(
                onTap: () {},
                child: Padding(
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
                            locale.clinicDetails,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                    children: [
                      Text(
                        locale.servicesAt,
                        style:
                        Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.edit,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutes.addHospital,
                            arguments: profileData.hospitals,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  EntryField(
                    readOnly: true,
                    initialValue: profileData.hospitals.isEmpty
                        ? ''
                        : profileData.hospitals[0].name,
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
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 15),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.edit,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutes.addService,
                            arguments: profileData.services,
                          );
                        },
                      ),
                    ],
                  ),
                  if (profileData.services.length >= 1)
                    SizedBox(
                      height: 12,
                    ),
                  if (profileData.services.length >= 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        profileData.services[0].name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  if (profileData.services.length >= 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        profileData.services[1].name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  if (profileData.services.length >= 1)
                    SizedBox(
                      height: 8,
                    ),
                  if (profileData.services.length >= 3)
                    Text(
                      '+${profileData.services.length - 2} ' + locale.more,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
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
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: 15),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.edit,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutes.addSpecialization,
                            arguments: profileData.specifications,
                          );
                        },
                      ),
                    ],
                  ),
                  if (profileData.specifications.length >= 1)
                    SizedBox(
                      height: 12,
                    ),
                  if (profileData.specifications.length >= 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        profileData.specifications[0].name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  if (profileData.specifications.length >= 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        profileData.specifications[1].name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  if (profileData.specifications.length >= 1)
                    SizedBox(
                      height: 8,
                    ),
                  if (profileData.specifications.length >= 3)
                    Text(
                      '+${profileData.specifications.length - 2} ' +
                          locale.more,
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
                      horizontal: 16.0, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        locale.availability,
                        style:
                        Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(),
                      buildTextButton(
                        text: locale.update,
                        onPress:
                        isAvailabilityLoading ? null : updateAvailability,
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
                    final availabilityItem =
                    profileData.availabilities[index];
                    return Padding(
                      padding:
                      EdgeInsetsDirectional.only(end: 8, bottom: 6),
                      child: Row(
                        children: [
                          Checkbox(
                            value: availabilityItem.isChecked,
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
                              availabilityItem.day
                                  .substring(0, 3)
                                  .capitalize(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                color:
                                Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                          _buildTimeSlotButton(
                            isFrom: true,
                            availabilityItem: availabilityItem,
                            index: index,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0),
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
