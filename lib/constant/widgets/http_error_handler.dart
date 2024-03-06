import 'dart:convert';

import 'package:erp_app/constant/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 401:
      showSnackBar(
        context: context,
        content: jsonDecode(response.body)['message'].toString(),
      );
      break;
    case 500:
      showSnackBar(
          context: context, content: jsonDecode(response.body)["error"]);
      break;
    default:
      showSnackBar(
        context: context,
        content: jsonDecode(response.body)['message'].toString(),
      );
  }
}
