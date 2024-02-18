import 'package:erp_app/features/common/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsletterAgreementWidget extends StatelessWidget {
  final bool newsletterAgreed;
  final VoidCallback changeNewsletter;

  const NewsletterAgreementWidget({
    Key? key,
    required this.newsletterAgreed,
    required this.changeNewsletter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1,
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: const Color(0xFF25284B),
            value: newsletterAgreed,
            onChanged: (_) {
              changeNewsletter();
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            changeNewsletter();
          },
          child: Text(
            'I agree with the Privacy Policies and T&C',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class SignInButtonWidget extends StatelessWidget {
  final bool newsletterAgreed;

  const SignInButtonWidget({Key? key, required this.newsletterAgreed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: newsletterAgreed
          ? TextButton(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPageScreen(role: "Student"),
                  ),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                iconColor: Colors.pinkAccent,
                backgroundColor: const Color(0xFF25284B),
                minimumSize: const Size.fromHeight(80),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    " Sign In ".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )
          : TextButton(
              onPressed: () async {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                iconColor: Colors.pinkAccent,
                backgroundColor: Colors.grey,
                minimumSize: const Size.fromHeight(80),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    " Sign In ".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.white, letterSpacing: 2.0),
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
    );
  }
}

class PageIndexButtonWidget extends StatelessWidget {
  final PageController controller;

  const PageIndexButtonWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      left: 80,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: TextButton(
          onPressed: () async {
            controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            iconColor: Colors.pinkAccent,
            backgroundColor: const Color(0xFF25284B),
            minimumSize: const Size.fromHeight(80),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Next".toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 15, color: Colors.white, letterSpacing: 2.0),
              ),
              const Icon(
                Icons.play_arrow_outlined,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
