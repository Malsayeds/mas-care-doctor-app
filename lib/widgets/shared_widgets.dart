import 'dart:io';

import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:doctoworld_doctor/utils/Theme/colors.dart';
import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  static void showToast({
    required String msg,
    bool? isError,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
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
      '',
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
}
