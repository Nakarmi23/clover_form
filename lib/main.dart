import 'package:bloc/bloc.dart';
import 'package:clover_form/clover_bloc_observer.dart';
import 'package:clover_form/feature/form_detail/view/form_detail_page.dart';
import 'package:clover_form/feature/home/models/form_model.dart';
import 'package:clover_form/feature/home/widgets/form_project.dart';
import 'package:clover_form/feature/home/widgets/form_project_list.dart';
import 'package:clover_form/feature/loading/view/loading_page.dart';
import 'package:clover_form/feature/login/view/login_page.dart';
import 'package:clover_form/feature/saved_form/models/SavedFormModel.dart';
import 'package:clover_form/feature/synced_form/view/synced_form_page.dart';
import 'package:clover_form/feature/url_entry/models/url_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'feature/confirmation/view/confirmation_page.dart';
import 'feature/home/view/home_page.dart';
import 'feature/saved_form/view/saved_form_page.dart';
import 'feature/url_entry/view/url_entry_page.dart';

class Test {
  Test({required this.url});
  String url;
}

void main() {
  Bloc.observer = const CloverBlocObserver();
  runApp(const CloverApp());
}

class CloverApp extends StatelessWidget {
  const CloverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(),
        '/urlEntry': (context) => const UrlEntryPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/syncedForm') {
          final formID = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return SyncedFormPage(
                formID: formID,
              );
            },
          );
        } else if (settings.name == '/savedForm') {
          final formID = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return SavedFormPage(
                formID: formID,
              );
            },
          );
        } else if (settings.name == '/confirmation') {
          final urlEntry = settings.arguments as UrlEntry;
          return MaterialPageRoute(
            builder: (context) {
              return ConfirmationPage(
                urlEntry: urlEntry,
              );
            },
          );
        } else if (settings.name == '/form_detail') {
          final form = settings.arguments;
          var formTitle = "";
          var formID = "";
          int id = 0;
          if (form is FormModel) {
            formTitle = form.DataCollectionFormName;
            formID = form.DataCollectionFormId;
          } else if (form is SavedFormModel) {
            formTitle = form.DataCollectionFormName;
            formID = form.DataCollectionFormId;
            id = form.id ?? 0;
          }
          return MaterialPageRoute(
            builder: (context) {
              return FormDetailPage(
                title: formTitle,
                formID: formID,
                id: id,
              );
            },
          );
        } else if (settings.name == '/form_project_list') {
          final from = settings.arguments;
          late String url;

          if (from is Test) {
            url = from.url;
          }

          return MaterialPageRoute(
            builder: (context) => FormProjectList(
              listURL: url,
            ),
          );
        } else if (settings.name == '/form_project') {
          final from = settings.arguments;

          return MaterialPageRoute(
            builder: (context) => FormProject(
              data: from as dynamic,
            ),
          );
        }
        return null;
      },
    );
  }
}
