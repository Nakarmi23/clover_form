import 'package:clover_form/network/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormProjectList extends StatefulWidget {
  const FormProjectList({super.key, required this.listURL});

  final String listURL;

  @override
  State<FormProjectList> createState() => _FormProjectListState();
}

class _FormProjectListState extends State<FormProjectList> {
  late dynamic list = [];

  @override
  void didChangeDependencies() {
    DioHelper.getInstance().dio.post(widget.listURL).then((result) {
      setState(() {
        list = result.data!;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = list[index] as Map<String, dynamic>;
          return ListTile(
            leading: Text((index + 1).toString()),
            title: Text(item['ProjectName']),
            onTap: () {
              Navigator.pushNamed(context, '/form_project', arguments: item);
            },
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
