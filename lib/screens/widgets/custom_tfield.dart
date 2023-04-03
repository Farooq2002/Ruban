import 'package:flutter/material.dart';

class CustomTField extends StatelessWidget {
  final String title;
  final String label;
  final TextInputType kType;
  final IconData icon;

  final TextEditingController controller;

  const CustomTField({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.kType,
    required this.label,
    String? errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: TextFormField(
            keyboardType: kType,
            controller: controller,
            decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                hintText: title,
                suffixIcon: Icon(icon)),
          ),
        ),
      ),
    );
  }
}
