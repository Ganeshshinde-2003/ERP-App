import 'package:erp_app/constant/models/notice_model.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_list.dart';
import 'package:erp_app/features/common/noticescreens/notice_details.dart';
import 'package:erp_app/features/teacher/controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class NoticePageScreen extends ConsumerStatefulWidget {
  final String who;
  const NoticePageScreen({super.key, required this.who});

  @override
  ConsumerState<NoticePageScreen> createState() => _NoticePageScreenState();
}

class _NoticePageScreenState extends ConsumerState<NoticePageScreen> {
  NoticesModel? noticesData;

  void fetchNotices() async {
    final notices = await ref
        .read(noticeControllerProvider)
        .fetchNotices(context, widget.who);

    if (mounted) {
      setState(() {
        noticesData = notices;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotices();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: noticesData != null
                    ? ListView.builder(
                        itemCount: noticesData!.data.length,
                        itemBuilder: (context, index) {
                          String noticeDateString =
                              noticesData!.data[index].noticeDate;
                          DateTime noticeDate =
                              DateTime.parse(noticeDateString);
                          String formattedDate =
                              DateFormat('MMMM d, y').format(noticeDate);

                          return ReusableNoticeCard(
                            subject: noticesData!.data[index].title,
                            date: formattedDate,
                            desc: noticesData!.data[index].description,
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
                                    title: noticesData!.data[index].title,
                                    desc: noticesData!.data[index].description,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : NoDataFound(deviceHeight, "assets/loading2.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
