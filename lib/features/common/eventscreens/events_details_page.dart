import 'package:erp_app/constant/models/events_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsDetailsPage extends StatelessWidget {
  final Event eventItem;
  const EventsDetailsPage({Key? key, required this.eventItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, eventItem.eventName),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 130,
              top: 30,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 10,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            width: deviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEventDetail('Event Name', eventItem.eventName),
                _buildEventDetail('Event Type', eventItem.eventType),
                _buildEventDetail('Event Date',
                    DateFormat('MMMM d, y').format(eventItem.eventDate)),
                _buildEventDetail('Description', eventItem.description),
                _buildEventDetail('Organizer', eventItem.organizer),
                _buildEventDetail('Location', eventItem.location),
                _buildEventDetail('Status', eventItem.eventStatus),
                _buildEventDetail(
                  'Last Updated',
                  DateFormat('MMMM d, y').format(eventItem.updatedAt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading1,
          ),
          Text(
            value,
            style: AppTextStyles.heading2,
          ),
        ],
      ),
    );
  }
}
