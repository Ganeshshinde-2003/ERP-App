import 'package:erp_app/constant/models/events_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/features/teacher/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CustomCarouselSlider extends ConsumerStatefulWidget {
  final String who;
  final double deviceWidth;
  final double deviceHeight;

  const CustomCarouselSlider({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.who,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends ConsumerState<CustomCarouselSlider> {
  EventsModel? eventsData;

  void fetchEvents() async {
    eventsData = await ref
        .read(eventsControllerProvider)
        .fetchEvents(context, widget.who);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return eventsData == null
        ? const CircularProgressIndicator()
        : CarouselSlider.builder(
            itemCount: eventsData!.data.length,
            itemBuilder: (context, index, realIndex) {
              final event = eventsData!.data[index];

              return CustomCarouselItem(
                deviceWidth: widget.deviceWidth,
                deviceHeight: widget.deviceHeight,
                title: event.eventType,
                subTitle: event.eventName,
                updatedOn: DateFormat('MMMM d, y').format(event.updatedAt),
                time: DateFormat('h:mm a').format(event.eventDate),
              );
            },
            options: CarouselOptions(
              height: widget.deviceHeight * 0.18,
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
