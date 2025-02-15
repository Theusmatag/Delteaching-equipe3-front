import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.label,
    this.readOnly,
    this.suffix,
    this.flex = 1,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.textType,
    this.contentPadding,
    this.initialValue,
    this.errorText,
  });

  final bool? readOnly;
  final Widget? suffix;
  final String label;
  final String? errorText;
  final int flex;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textType;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              label,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const Gap(5),
          TextFormField(
            cursorColor: Colors.black,
            readOnly: readOnly ?? false,
            initialValue: initialValue,
            decoration: InputDecoration(
              errorText: errorText,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.green),
              ),
              suffixIcon: suffix,
              contentPadding: contentPadding,
            ),
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            inputFormatters: inputFormatters,
            keyboardType: textType,
            minLines: minLines,
            maxLines: maxLines,
            maxLength: maxLength,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
