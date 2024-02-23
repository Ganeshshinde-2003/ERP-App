import 'package:erp_app/constant/data/student_onboarding.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/logo_loading.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/home_work_list.dart';
import 'package:erp_app/features/common/widgets/weekdays_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentHomeWorkPageScreen extends StatefulWidget {
  const StudentHomeWorkPageScreen({super.key});

  @override
  State<StudentHomeWorkPageScreen> createState() =>
      _StudentHomeWorkPageScreenState();
}

class _StudentHomeWorkPageScreenState extends State<StudentHomeWorkPageScreen>
    with TickerProviderStateMixin {
  String todaysMonth = DateFormat('MMMM').format(DateTime.now());
  bool isLading = true;
  bool isData = true;

  @override
  Widget build(BuildContext context) {
    StudentOnBoardingData studentOnBoardingData = StudentOnBoardingData();
    int initialIndex = studentOnBoardingData.months.indexOf(todaysMonth);
    if (initialIndex == -1) {
      initialIndex = 0;
    }

    var controller = TabController(
      length: 12,
      vsync: this,
      initialIndex: initialIndex,
    );

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Homework'),
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
                        studentOnBoardingData.months.indexOf(todaysMonth),
                    weekdays: studentOnBoardingData.months,
                    onIndexChanged: (index) {
                      setState(
                        () {
                          controller.animateTo(index);
                          todaysMonth = studentOnBoardingData.months[index];
                        },
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DividerWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Start", style: AppTextStyles.highlightedText),
                        Text("Date", style: AppTextStyles.highlightedText),
                        Text("Subject", style: AppTextStyles.highlightedText),
                        Text("Deadline", style: AppTextStyles.highlightedText),
                      ],
                    ),
                  ),
                  !isLading
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
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: !isData
                              ? NoDataFound(deviceHeight)
                              : HomeworkListWidget(
                                  homeworks: [
                                    Homework(
                                      date: '2022-02-24',
                                      desc: 'Do math homework',
                                    ),
                                    Homework(
                                      date: '2022-02-25',
                                      desc: 'Read a book',
                                    ),
                                  ],
                                ),
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
