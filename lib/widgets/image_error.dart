import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ImageError extends StatelessWidget {
  final VoidCallback onReload;
  ImageError(this.onReload);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.replay_outlined),
          color: Colors.white,
          onPressed: onReload,
        ),
      ),
    );
  }
}
