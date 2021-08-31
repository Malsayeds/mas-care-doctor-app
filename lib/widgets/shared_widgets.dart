import 'dart:io';

import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharedWidgets {
  static Future<File?> pickImage(ImageType imageType) async {
    File? pickedImage;
    XFile? image;
    final ImagePicker _picker = ImagePicker();

    if (imageType == ImageType.Camera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else if (imageType == ImageType.Gallery) {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      pickedImage = File(image.path);
    }

    return pickedImage;
  }

  static void launchURL(String url) async {
    await canLaunch(url)
        ? await launch(url)
        : showToast(
            msg: 'Could not launch $url',
            isError: true,
          );
  }

  static Widget buildEmptyImageText() {
    return Text(
      'No Image Picked',
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  static Future<void> launchPhoneCall(String phone) async {
    await canLaunch('tel:$phone')
        ? await launch('tel:$phone')
        : showToast(
            msg: 'Could not Call $phone',
            isError: true,
          );
  }

  static void showToast({
    required String msg,
    bool? isError,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ?? false ? redColor : primaryColor,
      textColor: Colors.white,
    );
  }

  static Widget buildImgNetwork({
    required String imgUrl,
    double? width,
    double? height,
  }) {
    return Image.network(
      imgUrl,
      width: width,
      height: height,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator.adaptive(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? trace) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Center(
            child: Text(
              '404',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget buildImgFile({
    required File imgFile,
    double? width,
    double? height,
  }) {
    return Image.file(
      imgFile,
      width: width,
      height: height,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? trace) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Center(
            child: Text(
              '404',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget showLoader() {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  static Widget buildChangeImgBottomSheetBody({
    required BuildContext ctx,
    VoidCallback? onCameraPressed,
    VoidCallback? onGalleryPressed,
  }) {
    final locale = AppLocalizations.of(ctx)!;
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
                onPressed: onCameraPressed,
                child: Text(locale.camera),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(ctx).primaryColor,
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
                onPressed: onGalleryPressed,
                child: Text(locale.gallery),
                style: TextButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(ctx).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
