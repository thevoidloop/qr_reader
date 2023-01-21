import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        // '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        const barcodeScanRes = 'https://www.facebook.com/danielmarroquin001';

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan('geo: 15.33, 15.66');
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
