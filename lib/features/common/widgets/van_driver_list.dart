import 'package:erp_app/features/student/screens/driver_map.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ReusableVanGridView extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ReusableVanGridView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 25.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1.9,
            crossAxisCount: 2,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final driverName = items[index]['firstName'];
            final driverDesc = items[index]['lastName'];
            final driverId = items[index]['driverId'];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: VanDriverLocationMap(driverId: driverId),
                    type: PageTransitionType.fade,
                    alignment: Alignment.lerp(
                      Alignment.centerLeft,
                      Alignment.centerLeft,
                      0.5,
                    ),
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
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        driverName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        driverDesc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
