// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:erp_app/constant/models/resources_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:erp_app/constant/widgets/notfound_data.dart';
import 'package:erp_app/constant/widgets/teacher/notice_bottom_image.dart';
import 'package:erp_app/features/common/subapp_bar.dart';
import 'package:erp_app/features/teacher/controller/upload_assigment_conroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceByClassAndSub extends ConsumerStatefulWidget {
  final String classId;
  final String subId;
  final String subName;
  final String whoIs;
  const ResourceByClassAndSub({
    Key? key,
    required this.classId,
    required this.subId,
    required this.subName,
    required this.whoIs,
  }) : super(key: key);

  @override
  ConsumerState<ResourceByClassAndSub> createState() =>
      _ResourceByClassAndSubState();
}

class _ResourceByClassAndSubState extends ConsumerState<ResourceByClassAndSub> {
  ResourceModel? resourceModelData;

  void getResources() async {
    resourceModelData =
        await ref.read(uploadAssignmentControllerProvider).getResources(
              context,
              widget.whoIs,
              widget.classId,
              widget.subId,
            );

    setState(() {});
  }

  @override
  void initState() {
    getResources();
    super.initState();
  }

  Future<void> _downloadFile(String url) async {
    var urlLink = Uri.parse(url);
    await launch(urlLink.toString());
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubPageAppBar(context, widget.subName),
      body: Stack(
        children: [
          BottomImageBar(deviceWidth: deviceWidth, color: "Green"),
          if (resourceModelData == null || resourceModelData!.data.isEmpty)
            Center(
                child: NoDataFound(
              deviceHeight,
              'assets/loading1.json',
              text: "No Resource Found",
            )),
          if (resourceModelData != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ListView.builder(
                itemCount: resourceModelData!.data.length,
                itemBuilder: (context, index) {
                  final resource = resourceModelData!.data[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                    child: ListTile(
                      title: Text(
                        resource.title,
                        style: AppTextStyles.heading1.copyWith(fontSize: 17),
                      ),
                      subtitle: Text(
                        resource.description.length > 20
                            ? "${resource.description.substring(0, 20)}..."
                            : resource.description,
                        style: AppTextStyles.sliderText
                            .copyWith(color: Colors.grey),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _downloadFile(resource.uploadedFileUrl);
                        },
                        child: const Icon(
                          Icons.file_copy_outlined,
                          color: Color(0xff03E627),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
