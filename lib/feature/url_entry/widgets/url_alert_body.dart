import 'package:clover_form/feature/shared/extension.dart';
import 'package:clover_form/feature/url_entry/models/url_entry.dart';
import 'package:flutter/cupertino.dart';

class UrlAlertBody extends StatelessWidget {
  const UrlAlertBody({super.key, required this.urlEntry});

  final UrlEntry? urlEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(urlEntry?.iconPath ?? ""),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(urlEntry?.title ?? "").bold14(),
        ),
        Text(urlEntry?.description ?? "").normal12(),
      ],
    );
  }
}
