import 'package:erp_app/constant/models/master_model.dart';
import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SubjectWiseMarkView extends StatelessWidget {
  final String whoCalling;
  final List<Section> items;
  final String currentYear;
  final Widget Function(String classId, String currentYear) onTap;

  const SubjectWiseMarkView({
    super.key,
    required this.items,
    required this.currentYear,
    required this.onTap,
    required this.whoCalling,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 1.9,
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
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
                child: onTap(items[index].sectionName, currentYear),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    items[index].sectionName,
                    style: AppTextStyles.sliderText.copyWith(fontSize: 13),
                  ),
                  whoCalling == "marks"
                      ? Text(
                          'Marks : 20',
                          style:
                              AppTextStyles.sliderText.copyWith(fontSize: 13),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
