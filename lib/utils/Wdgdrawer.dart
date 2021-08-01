import 'package:Muhasebe/screen/alisfatlist.dart';
import 'package:Muhasebe/screen/irsaliyelist.dart';
import 'package:Muhasebe/screen/kasalist.dart';
import 'package:Muhasebe/screen/mustlist.dart';
import 'package:Muhasebe/screen/satisfatlist.dart';
import 'package:Muhasebe/screen/stokgecmisui.dart';
import 'package:Muhasebe/screen/stokrap.dart';
import 'package:Muhasebe/screen/tedarikcilist.dart';
import 'package:Muhasebe/screen/urunlist.dart';
import 'package:Muhasebe/screen/alfatrapor.dart';
import 'package:Muhasebe/screen/gunceldurum.dart';

import 'package:Muhasebe/screen/satfatrapor.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                  FontAwesomeIcons.arrowDown,
                  color: Colors.grey,
                  size: 18,
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
                  FontAwesomeIcons.fileAlt,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Faturalar",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //   Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Satisfatli()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.building,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Müşteriler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //    Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Musterili()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.chartBar,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Satış Raporları",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //  Navigator.of(context).pop();
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
                  FontAwesomeIcons.arrowUp,
                  color: Colors.grey,
                  size: 18,
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
                  FontAwesomeIcons.fileAlt,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Gider Listesi",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //     Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alisfatli()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.truck,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Tedarikçiler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //    Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tedarikcili()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.chartBar,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Giderler Raporu",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //    Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Alfatrapor()));
                },
              ),
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.moneyBill,
                  color: Colors.grey,
                  size: 18,
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
                  FontAwesomeIcons.university,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Kasa ve Bankalar",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Kasali()));
                },
              ),
              /*    ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.grey,
                ),
                title: Text(
                  "Raporlar",
                  style: TextStyle(color: Colors.grey),
                ),
              ),*/
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.receipt,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Güncel Durum",
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
                  FontAwesomeIcons.receipt,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Güncel Durum",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Gunceldurum()));
                },
              ),
            ]),
        ExpansionTile(
            title: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.th,
                  color: Colors.grey,
                  size: 18,
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
                  FontAwesomeIcons.tags,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Hizmet ve Ürünler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //   Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Urunli()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.fileAlt,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Irsaliyeler",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //   Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Irsaliyeli()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.truckMoving,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Stok Geçmişi",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stokgecmisui()));
                },
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.chartBar,
                  color: Colors.grey,
                  size: 18,
                ),
                title: Text(
                  "Stoktaki Ürünler Raporu",
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  //  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Stokrap()));
                },
              ),
            ]),
      ],
    );
  }
}
