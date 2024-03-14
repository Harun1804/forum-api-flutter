import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.errorText,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 20
            ),
          errorText: errorText
        ),
      ),
    );
  }
}