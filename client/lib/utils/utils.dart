import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utils {
  static DateTime dateTimeFromString(String? string) {
    return (DateTime.tryParse(string ?? '') ?? DateTime.now()).toLocal();
  }

  static DateTime getToday() {
    final now = DateTime.now().toUtc();

    return DateTime.utc(now.year, now.month, now.day);
  }

  static Future<void> popNavigation(BuildContext context) async {
    if (kDebugMode) {
      print('navigating back');
    }

    await Navigator.of(context).maybePop();
  }

  static Future<void> showDefaultDialog({
    required BuildContext context,
    required String content,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                await Navigator.of(context).maybePop();
              },
            ),
          ],
        );
      },
    );
  }
}
