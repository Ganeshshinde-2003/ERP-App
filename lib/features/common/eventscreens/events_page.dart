import 'package:erp_app/constant/models/events_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/features/common/eventscreens/events_details_page.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/teacher/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsPageScreen extends ConsumerStatefulWidget {
  final String who;
  const EventsPageScreen({Key? key, required this.who}) : super(key: key);

  @override
  ConsumerState<EventsPageScreen> createState() => _EventsPageScreenState();
}

class _EventsPageScreenState extends ConsumerState<EventsPageScreen> {
  EventsModel? eventsData;
  late DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

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
    _selectedDay = DateTime.now();
  }

  bool isSameDayList(DateTime day, List<DateTime> dateList) {
    return dateList.any((date) =>
        day.year == date.year &&
        day.month == date.month &&
        day.day == date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Events'),
      body: Stack(
        children: [
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    Map<DateTime, List<dynamic>> highlightedDates = {};
    for (var event in eventsData?.data ?? []) {
      DateTime eventDate = event.eventDate;
      highlightedDates[eventDate] = highlightedDates[eventDate] ?? [];
      highlightedDates[eventDate]!.add(event);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDayList(day, highlightedDates.keys.toList());
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _selectedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(fontSize: 12),
                holidayTextStyle: TextStyle(fontSize: 12),
                weekendTextStyle: TextStyle(fontSize: 12),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: 12),
                weekendStyle: TextStyle(fontSize: 12),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  Color cellColor = Colors.transparent;

                  if (isSameDayList(date, highlightedDates.keys.toList())) {
                    cellColor = const Color(0xFF4094A8);
                  }

                  return Container(
                    margin: const EdgeInsets.all(11.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cellColor,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildEventsListView(),
        ],
      ),
    );
  }

  Widget _buildEventsListView() {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: eventsData?.data.isNotEmpty ?? false
          ? ListView.builder(
              itemCount: eventsData!.data.length,
              itemBuilder: (context, index) {
                Event eventItem = eventsData!.data[index];
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(eventItem.eventDate);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.lerp(
                          Alignment.centerLeft,
                          Alignment.centerLeft,
                          0.5,
                        ),
                        child: EventsDetailsPage(eventItem: eventItem),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                eventItem.eventName,
                                style: AppTextStyles.heading1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(formattedDate),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : NoDataFound(deviceHeight, "assets/loading2.json"),
    );
  }
}
