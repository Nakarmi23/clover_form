import 'package:flutter/material.dart';

extension TextBold14 on Text {
  Text bold14() {
    return Text(
      data ?? "",
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

extension Text12 on Text {
  Text normal12() {
    return Text(
      data ?? "",
      style: const TextStyle(
        fontSize: 12,
      ),
    );
  }
}
