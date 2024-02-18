import 'package:erp_app/constant/widgets/animated_logo.dart';
import 'package:erp_app/constant/widgets/button.dart';
import 'package:erp_app/constant/widgets/head_text.dart';
import 'package:erp_app/constant/widgets/position_image.dart';
import 'package:erp_app/constant/widgets/query_contact.dart';
import 'package:erp_app/features/common/login_page.dart';
import 'package:erp_app/features/student/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void onStudentButtonTap() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.lerp(
          Alignment.centerLeft,
          Alignment.centerLeft,
          0.5,
        ),
        child: const StudentOnBoaringScreen(),
      ),
    );
  }

  void onTeacherButtonTap(role) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.lerp(
          Alignment.centerLeft,
          Alignment.centerLeft,
          0.5,
        ),
        child: LoginPageScreen(role: role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: deviceHeight * 0.15),
                  SizedBox(height: deviceHeight * 0.1),
                  const Headingtext(text: "Select Role"),
                  ReusableLoginButton(
                    onTap: onStudentButtonTap,
                    buttonText: "Student",
                    useGradient: true,
                  ),
                  ReusableLoginButton(
                    onTap: () => onTeacherButtonTap("Teacher"),
                    buttonText: "Teacher",
                  ),
                  SizedBox(height: deviceHeight * 0.15),
                  AnimatedLogoText(deviceHeight: deviceHeight),
                  QueryContactInfoWidget(
                    onTapContactAdmin: () => {},
                    headText: "For any queries.",
                    discText: " Contact Admin",
                    pad: 50.0,
                  ),
                ],
              ),
            ),
            const PositionedImageWidget(
              top: 100,
              left: 260,
              imagePath: "assets/Polygon.png",
            ),
            const PositionedImageWidget(
              top: 50,
              left: 300,
              imagePath: "assets/Polygon.png",
            )
          ],
        ),
      ),
    );
  }
}
