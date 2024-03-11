import 'package:erp_app/constant/colors.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class ReusableNoticeCard extends StatelessWidget {
  final String subject;
  final String date;
  final String desc;
  final VoidCallback onTap;

  const ReusableNoticeCard({
    required this.subject,
    required this.date,
    required this.desc,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.mark_email_unread_rounded,
                    color: Colors.blue,
                    size: 30,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      subject,
                      style: AppTextStyles.heading1.copyWith(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  date,
                  maxLines: 1,
                  style: AppTextStyles.sliderText.copyWith(
                    color: TextColorScheme.secondaryTextColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
