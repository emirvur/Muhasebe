import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:flutter/material.dart';

class Satisbuton extends StatefulWidget {
  @override
  _SatisbutonState createState() => _SatisbutonState();
}

class _SatisbutonState extends State<Satisbuton> {
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
              child: Text("Faturalar")),
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
