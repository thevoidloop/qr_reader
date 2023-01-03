import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      onTap: (value) => uiProvider.selectedMenuOpt = value,
      currentIndex: uiProvider.selectedMenuOpt,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web),
          label: 'Direcciones',
        ),
      ],
    );
  }
}
