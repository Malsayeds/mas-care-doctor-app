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
  final String? label;
  final int? maxLines;
  final bool? isDense;
  final bool? isHidden;
  final VoidCallback? onTap;
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
    this.label,
    this.maxLines,
    this.isDense,
    this.onTap,
    this.isHidden,
    this.onSaved,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text(
                '\n' + label! + '\n',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
              )
            : SizedBox.shrink(),
        TextFormField(
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
            suffixIcon: Icon(suffixIcon),
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
        ),
      ],
    );
  }
}
