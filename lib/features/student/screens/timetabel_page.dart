import 'package:erp_app/constant/data/student_onboarding.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/head_text.dart';
import 'package:erp_app/constant/widgets/logo_loading.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/period_list_widget.dart';
import 'package:erp_app/features/common/widgets/weekdays_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentTimeTablePageScreen extends StatefulWidget {
  const StudentTimeTablePageScreen({Key? key}) : super(key: key);

  @override
  State<StudentTimeTablePageScreen> createState() =>
      _StudentTimeTablePageScreenState();
}

class _StudentTimeTablePageScreenState extends State<StudentTimeTablePageScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  bool isData = true;
  String todaysDate = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    StudentOnBoardingData studentOnBoardingData = StudentOnBoardingData();
    var controller = TabController(
      length: 7,
      vsync: this,
      initialIndex: studentOnBoardingData.weekdays.indexOf(todaysDate),
    );
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'TimeTable'),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          Container(
            height: deviceHeight,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  WeekdayNavigator(
                    currentIndex:
                        studentOnBoardingData.weekdays.indexOf(todaysDate),
                    weekdays: studentOnBoardingData.weekdays,
                    onIndexChanged: (index) {
                      setState(() {
                        controller.animateTo(index);
                        todaysDate = studentOnBoardingData.weekdays[index];
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DividerWidget(),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Headingtext(
                          text: "Subject",
                          textStyle: AppTextStyles.sliderText.copyWith(
                            fontSize: 15,
                          ),
                        ),
                        Headingtext(
                          text: "Time",
                          textStyle: AppTextStyles.sliderText.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? SizedBox(
                          height: deviceHeight * 0.3,
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              LogoLoading(deviceHeight),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: !isData
                              ? NoDataFound(deviceHeight, "assets/no_data.json")
                              : const PeriodsListWidget(),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
