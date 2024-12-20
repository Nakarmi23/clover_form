import 'package:clover_form/feature/home/models/form_model.dart';
import 'package:clover_form/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key, required this.forms});

  final List<FormModel> forms;

  @override
  State<StatefulWidget> createState() => HomeChildState();
}

class HomeChildState extends State<HomeChildPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var form =
            widget.forms.where((form) => form.FormType != '3').elementAt(index);

        return Slidable(
          key: ValueKey(form.DataCollectionFormId),
          // Required key for each Slidable
          startActionPane: ActionPane(
            motion: const StretchMotion(), // Replaces SlidableStrechActionPane
            extentRatio: 0.25, // Replaces actionExtentRatio
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, '/syncedForm',
                      arguments: form.DataCollectionFormId);
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.sync,
                label: 'Synced', // Replaces caption
              ),
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, '/savedForm',
                      arguments: form.DataCollectionFormId);
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: 'Saved', // Replaces caption
              ),
            ],
          ),
          child: Container(
            color: Colors.grey[200],
            child: ListTile(
              leading: Text(
                form.DataCollectionFormId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              title: Text(
                form.DataCollectionFormName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                if (form.FormType == '1') {
                  Navigator.pushNamed(context, '/form_detail', arguments: form);
                } else {
                  Navigator.pushNamed(
                    context,
                    '/form_project_list',
                    arguments: Test(url: form.ProjectListFetchURL!),
                  );
                }
              },
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.white),
      itemCount: widget.forms.where((form) => form.FormType != '3').length,
    );
  }
}
