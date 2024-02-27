import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/animated_logo.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/profile_widget.dart';
import 'package:erp_app/constant/widgets/teacher/teacher_button.dart';
import 'package:erp_app/features/common/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  bool isLoading = true;
  User? user;
  SharedStoreData sharedStoreData = SharedStoreData();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    User? loadedUser = await sharedStoreData.loadUserFromPreferences();

    setState(() {
      user = loadedUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ProfileRowWidget(
              name: user?.fullName ?? 'Loading...',
              id: user?.company_id ?? 'Loading...',
              role: user?.role == "admin" ? "Teacher" : "Student",
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
            onPressed: () => {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.centerLeft,
                    0.5,
                  ),
                  child: const LandingPage(),
                ),
              )
            },
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
