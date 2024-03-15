import 'package:erp_app/constant/models/fee_history_model.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildFeeHistoryListView(deviceWidth),
            ),
          ),
          BottomImageBar(
            deviceWidth: deviceWidth,
            color: "Green",
          ),
          if (feeHistory == null)
            Center(child: NoDataFound(deviceHeight, "assets/loading2.json")),
        ],
      ),
    );
  }

  Widget _buildFeeHistoryListView(double deviceWidth) {
    return ListView.builder(
      itemCount: feeHistory?.data.length ?? 0,
      itemBuilder: (context, index) {
        var feeItem = feeHistory!.data[index];

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
          margin: const EdgeInsets.symmetric(vertical: 8),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(statusInfo.icon, color: statusInfo.color),
                    const SizedBox(width: 8),
                    Text('Status: ${feeItem.status}'),
                  ],
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
