import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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
        content: body != null ? Text(body) : null,
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
