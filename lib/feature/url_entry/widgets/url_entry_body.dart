import 'package:clover_form/feature/url_entry/widgets/url_bottom_button.dart';
import 'package:clover_form/feature/url_entry/widgets/url_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/url_entry_cubit.dart';

class UrlEntryBody extends StatelessWidget {
  UrlEntryBody({super.key});

  final urlController = TextEditingController();

  String get _text => urlController.text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 23),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: UrlSection(
                    urlController: urlController,
                  ),
                ),
              ),
              const SizedBox(width: 6,),
              SizedBox(
                height: 60,
                child: UrlBottomButton(
                  onButtonPressed: () =>
                      context.read<UrlEntryCubit>().fetchSiteInfo(_text),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
