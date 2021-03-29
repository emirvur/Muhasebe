import 'package:Muhasebe/ui/stokgecmisiui.dart';
import 'package:Muhasebe/ui/stokrapor.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';

class Stokbuton extends StatefulWidget {
  @override
  _StokbutonState createState() => _StokbutonState();
}

class _StokbutonState extends State<Stokbuton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UrunlerUi()));
              },
              child: Text("Ürünler")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Stokgecmisiui()));
              },
              child: Text("Stok geçmişi")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Stokraporui()));
              },
              child: Text("Stok Rapor")),
        ],
      ),
    );
  }
}
