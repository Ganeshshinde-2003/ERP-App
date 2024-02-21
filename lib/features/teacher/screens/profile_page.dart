import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/animated_logo.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/profile_widget.dart';
import 'package:erp_app/constant/widgets/teacher/teacher_button.dart';
import 'package:flutter/material.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: ProfileRowWidget(
              name: "Ganesh",
              id: "02",
              role: "Teacher",
              profilePic: 'assets/avatar.png',
            ),
          ),
          SizedBox(height: deviceHeight * 0.02),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Account",
              style: AppTextStyles.highlightedText.copyWith(
                fontSize: 20,
              ),
            ),
          ),
          const DividerWidget(),
          ReusableContactAdminWidget(
            buttonText: "Contact Admin",
            imagePath: "assets/contact_admin.png",
            onPressed: () => {},
          ),
          const DividerWidget(),
          ReusableContactAdminWidget(
            buttonText: "Logout",
            imagePath: "assets/logout.png",
            onPressed: () => {},
          ),
          const DividerWidget(),
          const Spacer(), // Spacer takes remaining space
          AnimatedLogoText(
            deviceHeight: deviceHeight,
            imageHeight: 0.05,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
