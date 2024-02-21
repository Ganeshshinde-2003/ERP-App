import 'package:erp_app/constant/colors.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class ProfileRowWidget extends StatelessWidget {
  final String name;
  final String id;
  final String role;
  final String profilePic;

  const ProfileRowWidget({
    required this.name,
    required this.id,
    required this.role,
    required this.profilePic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                name,
                style: AppTextStyles.heading1,
              ),
              Text(
                '$id | $role',
                style: AppTextStyles.highlightedText.copyWith(
                  color: TextColorScheme.secondaryTextColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 1),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                profilePic,
                height: 70,
                width: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
