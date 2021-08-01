import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'dart:html' as html;

Future<List<int>> createexcel(final List<dynamic> lis) async {
  // var anchor;
  int i = 0;
  int j = 2;
  final Workbook workbook = new Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  if (lis is List<Dtourunhareket>) {
    print("1deede");
    sheet.getRangeByName('A1').setText("Ürün adı");
    sheet.getRangeByName('B1').setText("Br. Fiyat");
    sheet.getRangeByName('C1').setText("Miktar");
    sheet.getRangeByName('D1').setText("Vergi");
    print("2dede");
    for (int f = 0; f < lis.length; f++) {
      print("3te");

      String x = "A$j";
      String y = "B$j";
      String t = "C$j";
      String m = "D$j";
      sheet.getRangeByName(x).setText(lis[i].ad);
      print("4teete");
      sheet.getRangeByName(y).setText(lis[i].brfiyat.toString());
      sheet.getRangeByName(t).setText(lis[i].miktar.toString());
      sheet.getRangeByName(m).setText(lis[i].vergi.toString());
      i++;
      j++;
    }
  } else if (lis is List<Dtourun>) {
    print("1deede");
    sheet.getRangeByName('A1').setText("Barkod no");
    sheet.getRangeByName('B1').setText("Ürün adı");
    sheet.getRangeByName('C1').setText("Alis Fiyati(Vergiler hariç)");
    sheet.getRangeByName('D1').setText("Satış Fiyati(Vergiler hariç)");
    sheet.getRangeByName('E1').setText("Adet");
    sheet.getRangeByName('F1').setText("Kdv");
    print("2dede");
    for (int f = 0; f < lis.length; f++) {
      print("3te");

      String x = "A$j";
      String y = "B$j";
      String t = "C$j";
      String m = "D$j";
      String o = "E$j";
      String l = "F$j";
      sheet.getRangeByName(x).setText(lis[i].barkodno.toString());
      print("4teete");
      sheet.getRangeByName(y).setText(lis[i].adi.toString());
      sheet.getRangeByName(t).setText(lis[i].verharal.toString());
      sheet.getRangeByName(m).setText(lis[i].verharsat.toString());
      sheet.getRangeByName(o).setText(lis[i].adet.toString());
      sheet.getRangeByName(l).setText(lis[i].kdv.toString());
      i++;
      j++;
    }
  } else if (lis is List<Dtofattahs>) {
    print("1deede");
    sheet.getRangeByName('A1').setText("durum");
    sheet.getRangeByName('B1').setText("cariad");
    sheet.getRangeByName('C1').setText("duztarih");
    sheet.getRangeByName('D1').setText("fataciklama");
    sheet.getRangeByName('E1').setText("aratop");
    sheet.getRangeByName('F1').setText("araind");
    sheet.getRangeByName('G1').setText("kdv");
    sheet.getRangeByName('H1').setText("geneltoplam");
    sheet.getRangeByName('I1').setText("vadta");
    sheet.getRangeByName('J1').setText("alta");
    sheet.getRangeByName('K1').setText("alinmism");
    //sheet.getRangeByName('C1').setText("Miktar");
    //  sheet.getRangeByName('D1').setText("Vergi");
    print("2dede");
    for (int f = 0; f < lis.length; f++) {
      print("3te");

      String x = "A$j";
      String y = "B$j";
      String t = "C$j";
      String m = "D$j";
      String n = "E$j";
      String q = "F$j";
      String w = "G$j";
      String e = "H$j";
      String r = "J$j";
      String u = "J$j";

      sheet.getRangeByName(x).setText(lis[i].durum.toString());
      print("4teete");
      sheet.getRangeByName(y).setText(lis[i].cariad.toString());
      sheet.getRangeByName(t).setText(lis[i].duztarih);
      sheet.getRangeByName(m).setText(lis[i].fataciklama.toString());
      sheet.getRangeByName(n).setText(lis[i].aratop.toString().toString());
      sheet.getRangeByName(q).setText(lis[i].araind.toString());
      sheet.getRangeByName(w).setText(lis[i].kdv.toString());
      sheet.getRangeByName(e).setText(lis[i].geneltoplam.toString());
      sheet.getRangeByName(r).setText(lis[i].vadta.toString());
      sheet.getRangeByName(r).setText(lis[i].alta.toString());
      sheet.getRangeByName(u).setText(lis[i].alinmism.toString());
      //sheet.getRangeByName(t).setText(widget.lis[i].miktar.toString());
      //sheet.getRangeByName(m).setText(widget.lis[i].vergi.toString());
      i++;
      j++;
    }
  } else if (lis is List<Dtofatode>) {
    print("1deede");
    sheet.getRangeByName('A1').setText("durum");
    sheet.getRangeByName('B1').setText("cariad");
    sheet.getRangeByName('C1').setText("duztarih");
    sheet.getRangeByName('D1').setText("fataciklama");
    sheet.getRangeByName('E1').setText("aratop");
    sheet.getRangeByName('F1').setText("araind");
    sheet.getRangeByName('G1').setText("kdv");
    sheet.getRangeByName('H1').setText("geneltoplam");
    sheet.getRangeByName('I1').setText("odenecektar");
    sheet.getRangeByName('J1').setText("odenmistar");
    sheet.getRangeByName('K1').setText("odendimik");
    //sheet.getRangeByName('C1').setText("Miktar");
    //  sheet.getRangeByName('D1').setText("Vergi");
    print("2dede");
    for (int f = 0; f < lis.length; f++) {
      print("3te");

      String x = "A$j";
      String y = "B$j";
      String t = "C$j";
      String m = "D$j";
      String n = "E$j";
      String q = "F$j";
      String w = "G$j";
      String e = "H$j";
      String r = "J$j";
      String u = "J$j";

      sheet.getRangeByName(x).setText(lis[i].durum.toString());
      print("4teete");
      sheet.getRangeByName(y).setText(lis[i].cariad.toString());
      sheet.getRangeByName(t).setText(lis[i].duztarih);
      sheet.getRangeByName(m).setText(lis[i].fataciklama.toString());
      sheet.getRangeByName(n).setText(lis[i].aratop.toString().toString());
      sheet.getRangeByName(q).setText(lis[i].araind.toString());
      sheet.getRangeByName(w).setText(lis[i].kdv.toString());
      sheet.getRangeByName(e).setText(lis[i].geneltoplam.toString());
      sheet.getRangeByName(r).setText(lis[i].odenecektar.toString());
      sheet.getRangeByName(r).setText(lis[i].odenmistar.toString());
      sheet.getRangeByName(u).setText(lis[i].odendimik.toString());
      //sheet.getRangeByName(t).setText(widget.lis[i].miktar.toString());
      //sheet.getRangeByName(m).setText(widget.lis[i].vergi.toString());
      i++;
      j++;
    }
  } else if (lis is List<Dtocarilist>) {
    print("1deede");
    sheet.getRangeByName('A1').setText("Cari Unvanı");
    sheet.getRangeByName('B1').setText("Bakiye");
    //sheet.getRangeByName('C1').setText("Miktar");
    //  sheet.getRangeByName('D1').setText("Vergi");
    print("2dede");
    for (int f = 0; f < lis.length; f++) {
      print("3te");

      String x = "A$j";
      String y = "B$j";
      // String t = "C$j";
      //   String m = "D$j";
      sheet.getRangeByName(x).setText(lis[i].cariunvani);
      print("4teete");
      sheet.getRangeByName(y).setText(lis[i].bakiye.toString());
      //sheet.getRangeByName(t).setText(widget.lis[i].miktar.toString());
      //sheet.getRangeByName(m).setText(widget.lis[i].vergi.toString());
      i++;
      j++;
    }
  }
  List<int> bytes = workbook.saveAsStream();
  return bytes;

  /* final blob = html.Blob([bytes], 'application/excel');
  final url = html.Url.createObjectUrlFromBlob(blob);
  anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'exceltest.xlsx';
  html.document.body.children.add(anchor);*/
}

anchorexcel(List<int> bytes, String ad) {
  var anchor;
  final blob = html.Blob([bytes], 'application/excel');
  final url = html.Url.createObjectUrlFromBlob(blob);
  anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = '${ad}excel.xlsx';
  html.document.body.children.add(anchor);
  anchor.click();
}
