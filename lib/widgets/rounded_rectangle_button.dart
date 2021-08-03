import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String? btnText;
  final Color? btnColor;
  final Color? btnTextColor;
  final VoidCallback? btnPressed;

  const RoundedRectangleButton({
    this.btnText,
    this.btnColor,
    this.btnTextColor,
    required this.btnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          textStyle: TextStyle(
            color: btnTextColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          btnText ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        onPressed: btnPressed,
      ),
    );
  }
}
