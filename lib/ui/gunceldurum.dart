import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';

class Gunceldurum extends StatefulWidget {
  @override
  _GunceldurumState createState() => _GunceldurumState();
}

class _GunceldurumState extends State<Gunceldurum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          title: Wdgappbar("Güncel Durum", "", "Ahmet Seç")),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.black87, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(child: Wdgdrawer()),
      ),
      body: Container(
        height: 250,
        color: Colors.red,
      ),
    );
  }
}
