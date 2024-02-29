import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/class_past_button.dart';
import 'package:erp_app/features/common/widgets/put_attendance_list.dart';
import 'package:erp_app/features/teacher/controller/attendance_controller.dart';
import 'package:erp_app/features/teacher/screens/past_marks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadMarksScreen extends ConsumerStatefulWidget {
  const UploadMarksScreen({super.key});

  @override
  ConsumerState<UploadMarksScreen> createState() => _UploadMarksScreenState();
}

class _UploadMarksScreenState extends ConsumerState<UploadMarksScreen> {
  bool isLoading = true;
  List<Class>? classList;

  @override
  void initState() {
    super.initState();
    loadClassList();
  }

  Future<void> loadClassList() async {
    classList =
        await ref.read(masterDataUtilControllerProvider).getMasterClassData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Upload Marks'),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          SizedBox(
            height: deviceHeight,
            width: deviceWidth,
            child: Column(
              children: [
                const ReusableClassButtonWidget(
                  title: "Select Class and Subject",
                  buttonText: "Past Marks",
                  onPressed: PastMarksScreen(),
                ),
                SizedBox(
                  width: deviceWidth * 0.8,
                  child: const Divider(thickness: 1),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: !isLoading
                        // ignore: dead_code
                        ? NoDataFound(deviceHeight, 'assets/loading2.json')
                        // ignore: dead_code
                        : PutAttendanceListView(
                            whoCalling: "marks",
                            items: classList ?? [],
                            currentYear: '2022',
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
