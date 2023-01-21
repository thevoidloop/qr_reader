import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';

import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widget/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el provider

    final uiProvider = Provider.of<UiProvider>(context);

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (uiProvider.selectedMenuOpt) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const AddressesPage();
      default:
        scanListProvider.cargarScansPorTipo('http');
        return const MapasPage();
    }
  }
}
