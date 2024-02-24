import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/head_text.dart';
import 'package:erp_app/constant/widgets/logo_loading.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/divider_widget.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/common/widgets/van_driver_list.dart';
import 'package:flutter/material.dart';

class VanLiveTrackingScreen extends StatefulWidget {
  const VanLiveTrackingScreen({super.key});

  @override
  State<VanLiveTrackingScreen> createState() => _VanLiveTrackingScreenState();
}

class _VanLiveTrackingScreenState extends State<VanLiveTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    bool isLoading = false;
    final List<Map<String, dynamic>> staticData = [
      {'firstName': 'John', 'lastName': 'Doe', 'driverId': '1'},
      {'firstName': 'Jane', 'lastName': 'Smith', 'driverId': '2'},
    ];

    return Scaffold(
      appBar: SubPageAppBar(context, 'Track Van'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Headingtext(
                    text: 'Select Driver',
                    textStyle: AppTextStyles.heading2,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: DividerWidget(),
                ),
                // once the data is coming from backend add the no data image if no data and show below if data
                isLoading
                    // ignore: dead_code
                    ? SizedBox(
                        height: deviceHeight * 0.3,
                        child: Column(
                          children: [
                            Expanded(child: Container()),
                            LogoLoading(deviceHeight),
                          ],
                        ),
                      )
                    : staticData.isEmpty
                        ? NoDataFound(deviceHeight, "assets/no_data.json")
                        : ReusableVanGridView(items: staticData)
              ],
            ),
          )
        ],
      ),
    );
  }
}
