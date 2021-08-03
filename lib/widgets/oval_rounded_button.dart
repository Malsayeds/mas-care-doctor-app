import 'package:flutter/material.dart';

class OvalRoundedButton extends StatelessWidget {
  final Color? btnColor;
  final String? btnText;
  final VoidCallback? onBtnPressed;
  final Color? borderColor;

  const OvalRoundedButton({
    this.btnColor,
    this.btnText,
    this.borderColor,
    required this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          textStyle: TextStyle(
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: borderColor ?? Colors.black,
            ),
          ),
        ),
        child: Text(btnText ?? ''),
        onPressed: onBtnPressed,
      ),
    );
  }
}
