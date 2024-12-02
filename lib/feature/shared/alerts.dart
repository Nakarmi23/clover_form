import 'package:flutter/material.dart';

class Alerts {
  static AlertDialog showAlert(String title, String description) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        child: Text(description),
      ),
    );
  }

  static AlertDialog loadingAlert() {
    return const AlertDialog(
      title: Text(
        'Please wait',
        textAlign: TextAlign.center,
      ),
      content: LinearProgressIndicator(),
    );
  }

  AlertDialog showAlertWithButton(String title, String description) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.infinity,
        child: Text(description),
      ),
      actions: [
        ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text("Ok"),
        ),
        ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  static AlertDialog showYesNoButton(String title, Widget? child,
      Function onYesPressed, Function onNoPressed) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.infinity,
        child: child,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => {onYesPressed()},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () => {onNoPressed()},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
