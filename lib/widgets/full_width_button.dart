import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final String btnText;
  final Color btnColor;
  final Color btnTextColor;
  final IconData btnIcon;
  final onBtnPressed;

  const FullWidthButton({
    required this.btnText,
    required this.btnColor,
    required this.btnTextColor,
    required this.btnIcon,
    required this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          textStyle: TextStyle(
            color: btnTextColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        label: Text(btnText),
        icon: Icon(btnIcon),
        onPressed: onBtnPressed,
      ),
    );
  }
}
