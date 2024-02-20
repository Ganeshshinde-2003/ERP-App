import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        color: Colors.black,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const CenteredLogoWithTitle(
            title: 'IIIT BANGALORE',
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class InsidePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InsidePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarClipper(),
      child: Container(
        color: Colors.black,
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: const CenteredLogoWithTitle(
            title: 'INDIAN PUBLIC SCHOOL',
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CenteredLogoWithTitle extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const CenteredLogoWithTitle({
    Key? key,
    required this.title,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/odyssey-logo.png',
          height: 25,
          width: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: textStyle,
        ),
      ],
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 25.0;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
