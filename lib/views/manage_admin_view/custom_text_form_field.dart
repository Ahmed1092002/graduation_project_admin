// custom_text_form_field.dart

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: validator,
    );
  }
}
