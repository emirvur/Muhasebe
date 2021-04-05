import 'package:Muhasebe/models/stokrapor.dart';
import 'package:Muhasebe/ui/alisfatlist.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/musteriliste.dart';
import 'package:Muhasebe/ui/satfatrapor.dart';
import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:Muhasebe/ui/stokgecmisiui.dart';
import 'package:Muhasebe/ui/stokrapor.dart';
import 'package:Muhasebe/ui/tedarikcilist.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';

class Wdgdrawer extends StatelessWidget {
  const Wdgdrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: FlutterLogo(),
        ),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Satışlar",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_drop_down,
              size: 32,
              color: Colors.grey,
            ),
            onExpansionChanged: (value) {
              //     setState(() {
              //    isExpand=value;
              //       });
            },
            children: [
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Faturalar",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Satisfatlist()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Müşteriler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Musteriliste()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Satış Raporları",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Satfatrapor()));
                },
              ),
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Giderler",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_drop_down,
              size: 32,
              color: Colors.grey,
            ),
            onExpansionChanged: (value) {
              //  setState(() {
              //    isExpand=value;
              //    });
            },
            children: [
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Gider Listesi",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alisfatlist()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Tedarikçiler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tedarikciiste()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Raporlar",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Nakit",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_drop_down,
              size: 32,
              color: Colors.grey,
            ),
            onExpansionChanged: (value) {
              //     setState(() {
              //    isExpand=value;
              //       });
            },
            children: [
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Kasa ve Bankalar",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KasaListesiui()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Raporlar",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Stok",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_drop_down,
              size: 32,
              color: Colors.grey,
            ),
            onExpansionChanged: (value) {
              // setState(() {
              //    isExpand=value;
              //   }
              //  );
            },
            children: [
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Hizmet ve Ürünler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UrunlerUi()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Stok Geçmişi",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stokgecmisiui()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Stoktaki Ürünler Raporu",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stokraporui()));
                },
              ),
            ]),
      ],
    );
  }
}
