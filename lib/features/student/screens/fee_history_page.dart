import 'package:erp_app/constant/models/fee_history_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/student/controller/fee_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeeHistoryScreen extends ConsumerStatefulWidget {
  const FeeHistoryScreen({super.key});

  @override
  ConsumerState<FeeHistoryScreen> createState() => _FeeHistoryScreenState();
}

class _FeeHistoryScreenState extends ConsumerState<FeeHistoryScreen> {
  FeeHistory? feeHistory;

  void fetchFeesHistory() async {
    feeHistory =
        await ref.read(feeHistoryControllerProvider).fetchFeeHistory(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchFeesHistory();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, 'Fee Payment'),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 130,
                top: 30,
                left: 15,
                right: 15,
              ),
              padding: const EdgeInsets.all(10),
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
              child: _buildFeeHistoryListView(deviceWidth),
            ),
          ),
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          if (feeHistory == null || feeHistory!.data.isEmpty)
            Center(
              child: NoDataFound(
                deviceHeight,
                "assets/loading1.json",
                text: "No History Found",
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeeHistoryListView(double deviceWidth) {
    return ListView.builder(
      itemCount: feeHistory?.data.length ?? 0,
      itemBuilder: (context, index) {
        var feeItem = feeHistory!.data[index];
        // DateTime dateTime = DateTime.parse(feeItem.month);

        // String formattedDate = DateFormat('MMMM y').format(dateTime);
        StatusInfo statusInfo = getStatusInfo(feeItem.status);

        return Container(
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
          margin: const EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              ListTile(
                title: Text('Month: ${feeItem.month} Year: ${feeItem.year}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Due: ${feeItem.feeDue}'),
                    Text('Collected: ${feeItem.feeCollected}'),
                    Text('Balance: ${feeItem.balance}'),
                  ],
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: statusInfo.color,
                  ),
                  child: Text(
                    feeItem.status,
                    style: AppTextStyles.buttonText.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  StatusInfo getStatusInfo(String status) {
    switch (status.toLowerCase()) {
      case 'unpaid':
        return StatusInfo(Colors.red, Icons.warning);
      case 'partial paid':
        return StatusInfo(Colors.orange, Icons.warning);
      case 'paid':
        return StatusInfo(Colors.green, Icons.check_circle);
      default:
        return StatusInfo(Colors.black, Icons.error);
    }
  }
}

class StatusInfo {
  final Color color;
  final IconData icon;

  StatusInfo(this.color, this.icon);
}
