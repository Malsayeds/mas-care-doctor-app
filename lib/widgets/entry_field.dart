import 'package:doctoworld_doctor/utils/constants.dart';
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
  final String? label;
  final String? prefixText;
  final String? suffixText;
  final IconData? prefixIcon;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool? isDense;
  final bool? isHidden;
  bool canAutoValidate;
  final VoidCallback? onTap;
  final VoidCallback? suffixOnTap;
  final Function(String? text)? onSaved;
  final String? Function(String? text)? onValidate;

  EntryField({
    this.hint,
    this.label,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.color,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.maxLines,
    this.isDense,
    this.onTap,
    this.isHidden,
    this.onSaved,
    this.onValidate,
    this.suffixOnTap,
    this.canAutoValidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      initialValue: initialValue,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      obscureText: isHidden ?? false,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: textInputType,
      autovalidateMode: canAutoValidate ? AutovalidateMode.onUserInteraction : null,
      decoration: InputDecoration(
        isDense: isDense ?? false,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).primaryColor,
              )
            : null,
        prefixText: prefixText,
        suffixText: suffixText,
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: suffixOnTap,
        ),
        hintText: hint,
        labelText: label,
        filled: true,
        fillColor: color ?? Theme.of(context).primaryColorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      onSaved: onSaved,
      validator: onValidate,
    );
  }
}
