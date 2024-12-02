import 'package:clover_form/feature/home/cubit/home_cubit.dart';
import 'package:clover_form/feature/home/widgets/home_child_page.dart';
import 'package:clover_form/feature/home/widgets/home_error_page.dart';
import 'package:clover_form/feature/home/widgets/home_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {
            if (scaffoldKey.currentState!.isDrawerOpen)
              {scaffoldKey.currentState!.closeDrawer()}
            else
              {scaffoldKey.currentState!.openDrawer()}
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().getFormApi("1", "17");
            },
            child: const Text(
              "Get forms",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text("Reset"),
              onTap: () => context.read<HomeCubit>().reset(),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => context.read<HomeCubit>().logOut(),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: context.read<HomeCubit>()..getForms("1", "17"),
          builder: (context, state) {
            switch (state.formStatus) {
              case FormStatus.failed:
                return HomeErrorPage(errorMsg: state.errorMsg);
              case FormStatus.success:
                return HomeChildPage(forms: state.forms);
              default:
                return const HomeLoadingPage();
            }
          },
        ),
      ),
    );
  }
}
