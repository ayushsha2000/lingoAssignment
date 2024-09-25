import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingoassignment/constants/k_colors.dart';
import 'package:lingoassignment/constants/k_spacing.dart';
import 'package:lingoassignment/constants/k_text_style.dart';
import 'package:lingoassignment/helpers.dart';

class NewsTextField extends StatefulWidget {
  final String? title;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? hint;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final bool isMandatory;
  final bool? obsecureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextCapitalization cap;
  final int minLines;
  final int maxLines;
  final FocusNode? focusNode;

  const NewsTextField(
      {required this.controller,
      this.readOnly = false,
      this.title,
      this.inputType = TextInputType.text,
      this.hint,
      this.validator,
      this.label,
      this.onChanged,
      this.maxLength,
      this.prefixIcon,
      this.isMandatory = false,
      this.onTap,
      this.suffixIcon,
      this.cap = TextCapitalization.none,
      super.key,
      this.obsecureText,
      this.minLines = 1,
      this.maxLines = 1,
      this.focusNode,
      this.inputFormatters});

  @override
  State<NewsTextField> createState() => _NewsTextFieldState();
}

class _NewsTextFieldState extends State<NewsTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            children: widget.isMandatory
                ? <TextSpan>[
                    const TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red)),
                  ]
                : null,
          ),
        ),
        const SizedBox(
          height: Spacing.spacingBase,
        ),
        SizedBox(
          child: TextFormField(
            textCapitalization: widget.cap,
            validator: widget.validator,
            focusNode: widget.focusNode,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            inputFormatters: widget.inputFormatters,
            obscureText: widget.obsecureText ?? false,
            maxLength: widget.maxLength,
            keyboardType: widget.inputType,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            style: hintStyle.copyWith(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.whiteColor,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              labelText: widget.label,
              hintStyle: hintStyle.copyWith(color: Colors.black),
              hintText: widget.hint,
              errorMaxLines: 2,
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: defaultBorderRadius,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                borderRadius: defaultBorderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                borderRadius: defaultBorderRadius,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: defaultBorderRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
