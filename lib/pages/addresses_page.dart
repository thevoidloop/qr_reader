import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.home),
          title: Text(scans[index].valor),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () => print('abrir algo'),
        ),
        itemCount: scans.length,
      ),
    );
  }
}
