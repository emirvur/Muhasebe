import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:flutter/material.dart';

import 'alisfatlist.dart';

class Giderbuton extends StatefulWidget {
  @override
  _GiderbutonState createState() => _GiderbutonState();
}

class _GiderbutonState extends State<Giderbuton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Satisfatlist()));
              },
              child: Text("Satış Faturalar")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Alisfatlist()));
              },
              child: Text("Alış Faturalar")),
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
