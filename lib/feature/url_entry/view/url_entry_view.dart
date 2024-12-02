import 'package:flutter/material.dart';

import '../widgets/url_entry_body.dart';

class UrlEntryView extends StatelessWidget {
  const UrlEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UrlEntryBody(),
    );
  }
}
