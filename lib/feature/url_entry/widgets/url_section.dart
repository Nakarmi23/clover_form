import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/url_entry_cubit.dart';

class UrlSection extends StatefulWidget {
  const UrlSection({super.key, required this.urlController});

  final TextEditingController urlController;

  @override
  State<StatefulWidget> createState() => _UrlSectionState();
}

class _UrlSectionState extends State<UrlSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UrlEntryCubit, UrlEntryState>(
      builder: (context, state) {
        return TextField(
          controller: widget.urlController
            ..text = "https://nimis.dwri.gov.np/edmsadmin",
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(color: Colors.black, width: 4)),
            hintText: 'Server Url',
            errorText:
                state.status == UrlEntryStatus.invalid ? state.errorMsg : null,
          ),
        );
      },
    );
  }
}
