import 'dart:async';
import 'dart:io';
import 'package:erp_app/constant/widgets/app_bar.dart';
import 'package:erp_app/features/common/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Frame extends StatefulWidget {
  const Frame({Key? key}) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomePageScreen(),
    const Text("NoticePage"),
    const Text("ProfilePage"),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    });
  }

  Future<bool> _onBackPressed() async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Confirm Exit',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          content: Text(
            'Do you want to exit the app?',
            style: GoogleFonts.nunito(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 2, bottom: 2),
                  child: Text(
                    'No',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 2, bottom: 2),
                  child: Text(
                    'Yes',
                    style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    return await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChanged: _navigateBottomBar,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: SizedBox(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: BottomNavigationBar(
            elevation: 5,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            onTap: onTabChanged,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildBottomNavigationBarItem('Home', 'assets/home-icon.png'),
              _buildBottomNavigationBarItem(
                  'Notices', 'assets/notification-icon.png'),
              _buildBottomNavigationBarItem(
                  'Profile', 'assets/profile-icon.png'),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String label, String iconPath) {
    return BottomNavigationBarItem(
      label: label,
      activeIcon: _buildIconContainer(iconPath, Colors.blue),
      icon: _buildIconContainer(iconPath, Colors.black),
    );
  }

  Widget _buildIconContainer(String iconPath, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          iconPath,
          color: color,
          height: 22,
        ),
      ),
    );
  }
}
