import 'package:erp_app/constant/widgets/students/new_letter_agreement.dart';
import 'package:erp_app/constant/widgets/students/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentOnBoaringScreen extends StatefulWidget {
  const StudentOnBoaringScreen({super.key});

  @override
  State<StudentOnBoaringScreen> createState() => _StudentOnBoaringScreenState();
}

class _StudentOnBoaringScreenState extends State<StudentOnBoaringScreen> {
  final PageController controller = PageController();
  bool _newsletterAgreed = false;
  bool isLastPage = false;
  int currentIndex = 0;

  changeNewsLetter() {
    setState(() {
      _newsletterAgreed = !_newsletterAgreed;
    });
  }

  List<String> heading = [
    'Track Attendance',
    'Track Van Anytime',
    'AI Doubt Solving',
    'Resources',
    'And Other Features'
  ];

  List<String> headingdetails = [
    'Real Time Attendance of your Child',
    'See Where is van in real time map',
    '24 hour AI doubt Solving for enhanced learning',
    'All type of resources for complete learning',
    'Many more features on your fingetips'
  ];

  final List<String> onboardingItems = [
    'assets/on_track_attendance.png',
    'assets/on_track_van.png',
    'assets/on_ai.png',
    'assets/on_resources.png',
    'assets/on_other_features.png',
  ];

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 300),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    isLastPage = index == 4;
                  });
                },
                children: [
                  OnboardingItem(imagePath: onboardingItems[0]),
                  OnboardingItem(imagePath: onboardingItems[1]),
                  OnboardingItem(imagePath: onboardingItems[2]),
                  OnboardingItem(imagePath: onboardingItems[3]),
                  OnboardingItem(imagePath: onboardingItems[4]),
                ],
              ),
            ),
            Positioned(
              top: 400,
              child: SizedBox(
                width: deviceWidth,
                child: Column(
                  children: [
                    Text(
                      heading[currentIndex],
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 15,
                      ),
                      child: Text(
                        headingdetails[currentIndex],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 300,
              left: (deviceWidth - 120) / 2,
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 5,
                  onDotClicked: (index) => controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                  effect: const ScrollingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 4,
                    spacing: 15,
                    dotWidth: 10,
                    activeDotColor: Color(0xFF25284B),
                    activeDotScale: 2.5,
                    fixedCenter: false,
                    strokeWidth: 5,
                    activeStrokeWidth: 10,
                  ),
                ),
              ),
            ),
            isLastPage
                ? Positioned(
                    bottom: 120,
                    left: (deviceWidth - 300) / 2,
                    child: Column(
                      children: [
                        NewsletterAgreementWidget(
                          newsletterAgreed: _newsletterAgreed,
                          changeNewsletter: changeNewsLetter,
                        ),
                        SignInButtonWidget(
                          newsletterAgreed: _newsletterAgreed,
                        ),
                      ],
                    ),
                  )
                : PageIndexButtonWidget(
                    controller: controller,
                  ),
          ],
        ),
      ),
    );
  }
}
