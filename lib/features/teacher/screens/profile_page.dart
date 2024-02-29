import 'package:erp_app/constant/models/user_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/animated_logo.dart';
import 'package:erp_app/constant/widgets/show_dealog.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/profile_widget.dart';
import 'package:erp_app/constant/widgets/teacher/teacher_button.dart';
import 'package:erp_app/features/teacher/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePageScreen extends ConsumerStatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  ConsumerState<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends ConsumerState<ProfilePageScreen> {
  bool isLoading = true;
  User? user;
  SharedStoreData sharedStoreData = SharedStoreData();

  Future<void> _confirmLogout() async {
    bool? confirmed = await DialogHelper.showConfirmationDialog(
      context,
      true,
      "Logout",
      "Are you sure you want to logout?",
    );

    if (confirmed == true) {
      logoutUser();
    }
  }

  Future<void> _ContactAdmin() async {
    await DialogHelper.showConfirmationDialog(
      context,
      false,
      "Contact Admin",
      "Contact Info",
    );
  }

  void logoutUser() async {
    ref.read(loginTeahcerControllerProvider).logoutUser(context);
  }

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
            onPressed: _ContactAdmin,
          ),
          const DividerWidget(),
          ReusableContactAdminWidget(
            buttonText: "Logout",
            imagePath: "assets/logout.png",
            onPressed: _confirmLogout,
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
