import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final bool useGradient;

  const ReusableLoginButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: _buildContainerDecoration(),
          child: Center(
            child: Text(
              buttonText,
              style: GoogleFonts.nunito(
                color: useGradient ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    if (useGradient) {
      return BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.grey.shade600,
          Colors.black87,
          Colors.black,
        ]),
        boxShadow: [BoxShadow(color: Colors.grey.shade700, blurRadius: 0.3)],
      );
    } else {
      return const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1.0)],
      );
    }
  }
}
