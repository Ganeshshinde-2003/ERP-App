import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSlider extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;

  const CustomCarouselSlider({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        CustomCarouselItem(
          deviceWidth: deviceWidth,
          deviceHeight: deviceHeight,
          title: 'Events',
          subTitle: 'Sports Meet',
          updatedOn: '12 Sept 2023',
          time: '12:20 pm',
        ),
      ],
      options: CarouselOptions(
        height: deviceHeight * 0.18,
        aspectRatio: 12,
        viewportFraction: 0.93,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        autoPlayCurve: Curves.linearToEaseOut,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class CustomCarouselItem extends StatelessWidget {
  final double deviceWidth;
  final double deviceHeight;
  final String title;
  final String subTitle;
  final String updatedOn;
  final String time;

  const CustomCarouselItem({
    super.key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.title,
    required this.subTitle,
    required this.updatedOn,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/dashboard-abstract1.png'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.sliderText.copyWith(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    subTitle,
                    style: AppTextStyles.buttonText.copyWith(
                      fontSize: 21,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Updated on ',
                          style: AppTextStyles.sliderText,
                        ),
                        Text(
                          updatedOn,
                          style:
                              AppTextStyles.sliderText.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      time,
                      style: AppTextStyles.sliderText,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
