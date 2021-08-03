
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final double? iconGap;
  final Function? onTap;
  final Color? color;
  final Color? textColor;
  final double? padding;
  final double? radius;
  final Widget? trailing;
  final double? textSize;

  CustomButton({
    this.label,
    this.icon,
    this.iconGap,
    this.onTap,
    this.color,
    this.textColor : Colors.white,
    this.padding,
    this.radius,
    this.trailing,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: MediaQuery.of(context).size.height*.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: color ?? theme.primaryColor,
        ),
        padding: EdgeInsets.all(padding ?? (icon != null ? 16.0 : 18.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? SizedBox.shrink(),
            icon != null ? SizedBox(width: iconGap ?? 20) : SizedBox.shrink(),
            Expanded(
              child: Text(
                label ?? locale!.continuee,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.subtitle1!.copyWith(
                  color: textColor ?? theme.backgroundColor,
                  fontSize: textSize ?? 16,
                ),
              ),
            ),
            trailing != null ? Spacer() : SizedBox.shrink(),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}