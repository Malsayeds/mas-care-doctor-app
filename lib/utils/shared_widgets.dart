import 'dart:io';

import 'package:doctoworld_doctor/enums/image_type.dart';
import 'package:image_picker/image_picker.dart';

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
}
