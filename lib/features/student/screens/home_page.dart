import 'package:erp_app/constant/data/widget_data_student.dart';
import 'package:erp_app/constant/models/student_login_model.dart';
import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/students/carousel_slider.dart';
import 'package:erp_app/constant/widgets/students/custom_info_widget.dart';
import 'package:erp_app/constant/widgets/students/shimmer_effect.dart';
import 'package:flutter/material.dart';

class StudentHomePageScreen extends StatefulWidget {
  const StudentHomePageScreen({super.key});

  @override
  State<StudentHomePageScreen> createState() => _StudentHomePageScreenState();
}

class _StudentHomePageScreenState extends State<StudentHomePageScreen> {
  bool dashboardoading = false;
  bool isLoading = true;
  StudentLoginModel? user;
  SharedStoreData sharedStoreData = SharedStoreData();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    StudentLoginModel? loadUser =
        await sharedStoreData.loadStudentFromPreferences();
    setState(() {
      user = loadUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetDataStudent widgetDataStudent = WidgetDataStudent(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomUserInfoWidget(
              name: user?.data.user.fullName ?? "Unknown",
              role: "Student",
              rollNo: user?.data.admissionDetails.studentID.rollNo.toString() ??
                  "N/A",
              classNo:
                  '${user?.data.admissionDetails.classID.className ?? "Unknown"} ${user?.data.admissionDetails.sectionID.sectionName ?? "Unknown"}',
            ),
            SizedBox(height: deviceHeight * 0.01),
            SizedBox(height: deviceHeight * 0.01),
            dashboardoading
                ? ShimmerEffectWidget(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    isLoading: isLoading,
                  )
                : CustomCarouselSlider(
                    who: "Student",
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                  ),
            SizedBox(
              height: deviceHeight * 0.275,
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1.9,
                  ),
                  children: widgetDataStudent.menuItems,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Full Menu',
                    style: AppTextStyles.buttonText.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight * 0.45,
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 1.5,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 0.8,
                  ),
                  children: widgetDataStudent.fullMenuItems,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
