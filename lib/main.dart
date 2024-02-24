import 'package:erp_app/features/common/bottom_navigation.dart';
// import 'package:erp_app/features/common/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: const LandingPage(),
      home: const Frame(role: "Teacher"),
    );
  }
}
