import 'package:erp_app/constant/text_style.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool?> showConfirmationDialog(
    BuildContext context,
    bool isThisLogout,
    String title,
    String content,
  ) async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            isThisLogout
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "Yes",
                      style: AppTextStyles.highlightedText,
                    ),
                  )
                : Container(),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                isThisLogout ? "No" : "Close",
                style: AppTextStyles.highlightedText,
              ),
            ),
          ],
        );
      },
    );
  }
}
