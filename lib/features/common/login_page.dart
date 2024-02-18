import 'package:erp_app/constant/widgets/animated_logo.dart';
import 'package:erp_app/constant/widgets/custom_button.dart';
import 'package:erp_app/constant/widgets/head_disc_widget.dart';
import 'package:erp_app/constant/widgets/input_field.dart';
import 'package:erp_app/constant/widgets/query_contact.dart';
import 'package:flutter/material.dart';

class LoginPageScreen extends StatefulWidget {
  final String role;
  const LoginPageScreen({super.key, required this.role});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: deviceHeight * 0.05),
            AnimatedLogoText(
              deviceHeight: deviceHeight,
              imageHeight: 0.05,
              fontSize: 20,
            ),
            Center(
              child: SizedBox(
                height: deviceHeight * 0.35,
                child: Image.asset('assets/teacher-extract.png'),
              ),
            ),
            const HeadDiscWidget(
              title: "Sign in",
              subtitle: "Please sign in to continue",
            ),
            CustomInputField(
              controller: idController,
              label: widget.role == "Teacher" ? "Teacher ID" : "Student ID",
              hintText:
                  "Enter Your ${widget.role == "Teacher" ? "Teacher ID" : "Student ID"}",
            ),
            SizedBox(height: deviceHeight * 0.01),
            CustomInputField(
              controller: passwordController,
              label: "Password",
              hintText: "Enter Your Password",
            ),
            SizedBox(height: deviceHeight * 0.06),
            Center(
              child: CustomButtonWidget(
                buttonText: "Sign in",
                onPressed: () => {},
                isLoading: false,
              ),
            ),
            widget.role == "Student"
                ? QueryContactInfoWidget(
                    onTapContactAdmin: () => {},
                    headText: "New Admissions? ",
                    discText: "Apply",
                    pad: 40.0,
                  )
                : const SizedBox(),
            QueryContactInfoWidget(
              onTapContactAdmin: () => {},
              headText: "For any queries.",
              discText: " Contact Admin",
              pad: widget.role == "Student" ? 5.0 : 50.0,
            ),
          ],
        ),
      ),
    ));
  }
}
