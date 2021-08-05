import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
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
  final VoidCallback? onTap;
  final VoidCallback? suffixOnTap;
  final Function(String? text)? onSaved;
  final String? Function(String? text)? onValidate;

  EntryField({
    this.hint,
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
      decoration: InputDecoration(
        isDense: isDense ?? false,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).primaryColor,
              )
            : null,
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: suffixOnTap,
        ),
        hintText: hint,
        filled: true,
        fillColor: color ?? Theme.of(context).primaryColorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onSaved: onSaved,
      validator: onValidate,
    );
  }
}
