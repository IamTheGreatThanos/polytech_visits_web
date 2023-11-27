import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polytech_visits_web/services/network_service.dart';

import '../../models/signInHistory.dart';
import '../../utils/styles/color_palette.dart';
import '../../widgets/custom_snackbar.dart';
import '../auth/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  List<SignInHistory> signInHistory = [];

  @override
  void initState() {
    super.initState();
    getHistory();
    timer =
        Timer.periodic(const Duration(seconds: 5), (Timer t) => getHistory());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 130,
                color: ColorPalette.main,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 30),
                        const Spacer(),
                        SizedBox(
                          width: 250,
                          height: 100,
                          child: Image.asset('assets/images/logo_white.png'),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(EventAuthLogout());
                          },
                          child: const Icon(
                            Icons.exit_to_app,
                            size: 28,
                            color: ColorPalette.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 550,
                        child: SingleChildScrollView(
                          child: Material(
                            elevation: 3,
                            child: Container(
                              color: ColorPalette.white,
                              width: double.infinity,
                              child: _createDataTable(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ID')),
      const DataColumn(label: Text('Кабинет')),
      const DataColumn(label: Text('Время')),
      const DataColumn(label: Text('Статус')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      for (int i = 0; i < signInHistory.length; i++)
        DataRow(
          cells: [
            DataCell(Text(
                "${signInHistory[i].user.firstName} ${signInHistory[i].user.lastName}")),
            DataCell(Text(signInHistory[i].auditory.number)),
            DataCell(Text(signInHistory[i].lastPick ?? '')),
            DataCell(Text(signInHistory[i].status == 1
                ? 'Доступ открыт'
                : 'Доступ закрыт')),
          ],
        ),
    ];
  }

  void getHistory() async {
    try {
      var response = await NetworkService().getEntryHistory();
      if (response != null) {
        signInHistory = [];
        for (var item in response) {
          signInHistory.add(SignInHistory.fromJson(item));
        }

        setState(() {});
      }
    } catch (error) {
      showCustomSnackBar(context, error.toString());
    }
  }
}
