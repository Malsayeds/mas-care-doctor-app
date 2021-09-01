import 'dart:io';

import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/providers/auth.dart';
import 'package:doctoworld_doctor/screens/Auth/Verification/pending_screen.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:doctoworld_doctor/widgets/custom_button.dart';
import 'package:doctoworld_doctor/widgets/entry_field.dart';
import 'package:doctoworld_doctor/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class IdentityScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/identityScreen';

  const IdentityScreen({Key? key}) : super(key: key);

  @override
  _IdentityScreenState createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  final qualificationController = TextEditingController();
  File? profile;
  File? certificate;
  File? nationalId;

  bool isSending = false;

  Future<void> verifyIdentity() async {
    try {
      setState(() {
        isSending = true;
      });
      final authData = Provider.of<Auth>(context, listen: false);
      await authData.verifyIdentity(
        profileImg: profile!,
        certificateImg: certificate!,
        nationalIDImg: nationalId!,
        qualification: qualificationController.text,
      );
      Navigator.of(context).pushReplacementNamed(PendingScreen.ROUTE_NAME);
      setState(() {
        isSending = false;
      });
    } catch (e) {
      print(e);
      SharedWidgets.showToast(msg: INTERNET_WARNING_MESSAGE);
      setState(() {
        isSending = false;
      });
    }
  }

  Widget buildTitleText({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget buildIdentityCategory({
    required String btnText,
    required String titleText,
    required IconData btnIcon,
    required File? img,
    VoidCallback? onBtnPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTitleText(title: titleText),
        img == null
            ? SizedBox(
                height: 150,
                child: Center(
                  child: SharedWidgets.buildEmptyImageText(),
                ),
              )
            : SharedWidgets.buildImgFile(
                imgFile: img,
                height: 150,
              ),
        TextButton.icon(
          onPressed: onBtnPressed,
          label: Text(btnText),
          icon: Icon(btnIcon),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    qualificationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Identity Verification'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildIdentityCategory(
                img: profile,
                btnIcon: Icons.camera_alt,
                btnText: 'Upload Image',
                titleText: 'Personal Image',
                onBtnPressed: () async {
                  FocusScope.of(context).unfocus();
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SharedWidgets.buildChangeImgBottomSheetBody(
                        ctx: context,
                        onCameraPressed: () async {
                          Navigator.of(context).pop(context);
                          profile =
                              await SharedWidgets.pickImage(ImageType.Camera);
                          setState(() {});
                        },
                        onGalleryPressed: () async {
                          Navigator.of(context).pop(context);
                          profile =
                              await SharedWidgets.pickImage(ImageType.Gallery);
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
              Divider(),
              buildIdentityCategory(
                img: certificate,
                btnIcon: Icons.camera_alt,
                btnText: 'Upload Image',
                titleText: 'Professional Training Certificate',
                onBtnPressed: () async {
                  FocusScope.of(context).unfocus();
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SharedWidgets.buildChangeImgBottomSheetBody(
                        ctx: context,
                        onCameraPressed: () async {
                          Navigator.of(context).pop(context);
                          certificate =
                              await SharedWidgets.pickImage(ImageType.Camera);
                          setState(() {});
                        },
                        onGalleryPressed: () async {
                          Navigator.of(context).pop(context);
                          certificate =
                              await SharedWidgets.pickImage(ImageType.Gallery);
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
              Divider(),
              buildIdentityCategory(
                btnText: 'Upload image',
                btnIcon: Icons.camera_alt_outlined,
                img: nationalId,
                onBtnPressed: () async {
                  FocusScope.of(context).unfocus();
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SharedWidgets.buildChangeImgBottomSheetBody(
                        ctx: context,
                        onCameraPressed: () async {
                          Navigator.of(context).pop(context);
                          nationalId =
                              await SharedWidgets.pickImage(ImageType.Camera);
                          setState(() {});
                        },
                        onGalleryPressed: () async {
                          Navigator.of(context).pop(context);
                          nationalId =
                              await SharedWidgets.pickImage(ImageType.Gallery);
                          setState(() {});
                        },
                      );
                    },
                  );
                },
                titleText: 'Personal National ID',
              ),
              Divider(),
              buildTitleText(title: 'Qualifications'),
              SizedBox(
                height: 8,
              ),
              EntryField(
                controller: qualificationController,
                canAutoValidate: true,
                hint: 'Enter your Qualifications',
                label: 'Qualifications',
                maxLines: 5,
                onValidate: (text) {
                  if (text == null || text == '') {
                    return 'Qualifications can\'t be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomButton(
                label: locale.submit,
                onTap: isSending
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (profile != null &&
                            certificate != null &&
                            nationalId != null &&
                            qualificationController.text.isNotEmpty) {
                          await verifyIdentity();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Fill the missing data to proceed'),
                            ),
                          );
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
