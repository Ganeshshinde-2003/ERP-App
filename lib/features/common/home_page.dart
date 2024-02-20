import 'package:erp_app/constant/data/widget_data.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/students/carousel_slider.dart';
import 'package:erp_app/constant/widgets/students/custom_info_widget.dart';
import 'package:erp_app/constant/widgets/students/shimmer_effect.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool dashboardoading = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    WidgetData widgetData = WidgetData(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const CustomUserInfoWidget(name: "Ganesh"),
            SizedBox(height: deviceHeight * 0.01),
            SizedBox(height: deviceHeight * 0.01),
            dashboardoading
                ? ShimmerEffectWidget(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    isLoading: isLoading)
                : CustomCarouselSlider(
                    deviceWidth: deviceWidth, deviceHeight: deviceHeight),
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
                  children: widgetData.menuItems,
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
                  children: widgetData.fullMenuItems,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
