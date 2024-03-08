import 'package:erp_app/constant/provider/user_provider.dart';
import 'package:erp_app/features/common/bottom_navigation.dart';
import 'package:erp_app/features/common/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignin = false;
  String role = "";

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    final sharedStoreData = SharedStoreData();
    final userRole = await sharedStoreData.getUserRole();

    setState(() {
      if (userRole != null) {
        _isSignin = true;
        role = userRole.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: _isSignin
          ? Frame(role: role == "teacher" ? "Teacher" : "Student")
          : const LandingPage(),
    );
  }
}
