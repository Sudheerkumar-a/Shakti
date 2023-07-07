import 'package:flutter/material.dart';

class Dialogs {
  static Future<T?> loader<T>(BuildContext context) {
    return showDialog<T>(
      //prevent outside touch
      barrierDismissible: false,
      context: context,
      builder: (context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () async => true,
            child: const AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }

  static Future showInfoDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: const Text("Okay")),
        ],
      ),
    );
  }
}
