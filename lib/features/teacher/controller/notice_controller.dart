import 'package:erp_app/constant/models/notice_model.dart';
import 'package:erp_app/features/teacher/service/notice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticeControllerProvider = Provider((ref) {
  final noticeSerivce = ref.watch(noticeServiceProvider);
  return NoticeController(noticeSerivce: noticeSerivce, ref: ref);
});

class NoticeController {
  final NoticeSerivce noticeSerivce;
  final ProviderRef ref;

  NoticeController({required this.noticeSerivce, required this.ref});

  Future<NoticesModel?> fetchNotices(BuildContext context, String who) async {
    return await noticeSerivce.fetchNotice(context: context, who: who);
  }
}
