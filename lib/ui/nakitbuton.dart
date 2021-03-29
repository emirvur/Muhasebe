import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:flutter/material.dart';

class Nakitbuton extends StatefulWidget {
  @override
  _NakitbutonState createState() => _NakitbutonState();
}

class _NakitbutonState extends State<Nakitbuton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KasaListesiui()));
              },
              child: Text("Kasalar")),
          /* TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Satisfatlist()));
              },
              child: Text("Müşteriler")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Stokraporui()));
              },
              child: Text("Satış Rapor")),
                TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Stokraporui()));
              },
              child: Text("Tahsilat Rapor")),*/
        ],
      ),
    );
  }
}
