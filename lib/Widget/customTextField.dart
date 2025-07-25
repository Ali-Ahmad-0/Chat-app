import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.onChanged,
      required this.secured,
      this.textHint,
      this.sufIcon,
      required this.icon});
  String? textHint;
  Function(String)? onChanged;
  final Icon? icon;
  final Icon? sufIcon;
  bool? secured;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secured!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required !';
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.white,
        
      ),
      cursorColor: Colors.white,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: sufIcon,
        hintText: textHint,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white)),
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
