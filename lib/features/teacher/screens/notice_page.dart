import 'package:erp_app/constant/widgets/teacher/notice_list.dart';
import 'package:erp_app/features/teacher/screens/notice_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NoticePageScreen extends StatefulWidget {
  const NoticePageScreen({super.key});

  @override
  State<NoticePageScreen> createState() => _NoticePageScreenState();
}

class _NoticePageScreenState extends State<NoticePageScreen> {
  // Dummy data
  final List<Notice> notices = [
    Notice(
      subject: 'Important Notice 1',
      desc: 'This is the description for notice 1.',
      date: '2022-01-01',
      time: '10:00 AM',
    ),
    Notice(
      subject: 'Important Notice 2',
      desc: 'This is the description for notice 2.',
      date: '2022-02-01',
      time: '12:00 PM',
    ),
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    return ReusableNoticeCard(
                      subject: notices[index].subject,
                      date: notices[index].date,
                      time: notices[index].time,
                      desc: notices[index].desc,
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
                            child: NoticeDetails(
                              title: notices[index].subject,
                              desc: notices[index].desc,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Notice {
  final String subject;
  final String desc;
  final String date;
  final String time;

  Notice({
    required this.subject,
    required this.desc,
    required this.date,
    required this.time,
  });
}
