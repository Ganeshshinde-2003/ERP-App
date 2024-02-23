import 'package:flutter/material.dart';

class HomeworkListWidget extends StatelessWidget {
  final List<Homework> homeworks;

  const HomeworkListWidget({super.key, required this.homeworks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: homeworks.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () async {
              // Handle onTap if needed
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      homeworks[index].date,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      homeworks[index].desc,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Homework {
  final String date;
  final String desc;

  Homework({required this.date, required this.desc});
}
