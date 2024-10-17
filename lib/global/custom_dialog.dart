import 'package:flutter/cupertino.dart';

class CustomDialog {
  static void showWarningDialog(
    BuildContext context, {
    required String title,
     String? body,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: body != null ?  Text(body) : null,
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
