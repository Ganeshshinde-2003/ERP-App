import 'package:erp_app/constant/models/view_assignment_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/teacher/controller/upload_assigment_conroller.dart';
import 'package:erp_app/features/teacher/screens/upload_assignment/assignment_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class ViewAssignmentScreeb extends ConsumerStatefulWidget {
  final String sectionId;
  final String subId;
  const ViewAssignmentScreeb({
    super.key,
    required this.sectionId,
    required this.subId,
  });

  @override
  ConsumerState<ViewAssignmentScreeb> createState() =>
      _ViewAssignmentScreebState();
}

class _ViewAssignmentScreebState extends ConsumerState<ViewAssignmentScreeb> {
  AssignmentDataModel? assignmentViewData;

  void getAssignmentData() async {
    assignmentViewData = await ref
        .read(uploadAssignmentControllerProvider)
        .getAssingmentBySectionId(
          sectionId: widget.sectionId,
          subId: widget.subId,
          context: context,
        );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAssignmentData();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, "Assignment"),
      body: Stack(
        children: [
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 50, left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Title",
                      style: AppTextStyles.highlightedText.copyWith(
                        color: const Color(0xffB0B0B0),
                      ),
                    ),
                    Text(
                      "Deadline",
                      style: AppTextStyles.highlightedText.copyWith(
                        color: const Color(0xffB0B0B0),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Divider(height: 2),
              )
            ],
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceHeight,
              width: deviceWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 65.0,
                ),
                child: assignmentViewData != null
                    ? _buildAssignmentListView(assignmentViewData!.data)
                    : _buildLoadingIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAssignmentListView(List<AssignmentData> assignments) {
    var deviceHeight = MediaQuery.of(context).size.height;
    if (assignments.isEmpty) {
      return NoDataFound(deviceHeight, 'assets/loading1.json');
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 130),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.white,
        child: ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            AssignmentData assignment = assignments[index];
            String formattedDueDate =
                DateFormat.yMMMMd().format(assignment.dueDate);
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 235, 224),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  assignment.title,
                  style: AppTextStyles.heading1,
                ),
                trailing: Text(
                  formattedDueDate,
                  style: AppTextStyles.heading2.copyWith(fontSize: 12),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: AssignmentDetailsScreen(
                        assignmentData: assignment,
                      ),
                      type: PageTransitionType.fade,
                      alignment: Alignment.lerp(
                          Alignment.centerLeft, Alignment.centerLeft, 0.5),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildLoadingIndicator() {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Center(child: NoDataFound(deviceHeight, 'assets/loading2.json'));
  }
}
