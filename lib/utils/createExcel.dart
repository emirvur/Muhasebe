//My answer is a variant on Yonkee above specifically for flutter web. In this answer, I have added the imports required (dart:html and dart:typed_data) and added formatting of text as I needed that feature.
/*
import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:io';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class PDFExcel extends StatefulWidget {
  final dynamic dto;
  final List<dynamic> lis;
  PDFExcel(this.dto, this.lis);
  @override
  _PDFExcelState createState() => _PDFExcelState();
}

class _PDFExcelState extends State<PDFExcel> {
  var anchor;
  int i = 0;
  int j = 2;

  //  var excel;

  saveexcel() async {
    final Workbook workbook = new Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    if (widget.lis is List<Dtourunhareket>) {
      print("1deede");
      sheet.getRangeByName('A1').setText("Ürün adı");
      sheet.getRangeByName('B1').setText("Br. Fiyat");
      sheet.getRangeByName('C1').setText("Miktar");
      sheet.getRangeByName('D1').setText("Vergi");
      print("2dede");
      for (int f = 0; f < widget.lis.length; f++) {
        print("3te");

        String x = "A$j";
        String y = "B$j";
        String t = "C$j";
        String m = "D$j";
        sheet.getRangeByName(x).setText(widget.lis[i].ad);
        print("4teete");
        sheet.getRangeByName(y).setText(widget.lis[i].brfiyat.toString());
        sheet.getRangeByName(t).setText(widget.lis[i].miktar.toString());
        sheet.getRangeByName(m).setText(widget.lis[i].vergi.toString());
        i++;
        j++;
      }
    } else if (widget.lis is List<Dtocarilist>) {
      print("1deede");
      sheet.getRangeByName('A1').setText("Cari Unvanı");
      sheet.getRangeByName('B1').setText("Bakiye");
      //sheet.getRangeByName('C1').setText("Miktar");
      //  sheet.getRangeByName('D1').setText("Vergi");
      print("2dede");
      for (int f = 0; f < widget.lis.length; f++) {
        print("3te");

        String x = "A$j";
        String y = "B$j";
        // String t = "C$j";
        //   String m = "D$j";
        sheet.getRangeByName(x).setText(widget.lis[i].cariunvani);
        print("4teete");
        sheet.getRangeByName(y).setText(widget.lis[i].bakiye.toString());
        //sheet.getRangeByName(t).setText(widget.lis[i].miktar.toString());
        //sheet.getRangeByName(m).setText(widget.lis[i].vergi.toString());
        i++;
        j++;
      }
    }
    List<int> bytes = workbook.saveAsStream();

    final blob = html.Blob([bytes], 'application/excel');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'exceltest.xlsx';
    html.document.body.children.add(anchor);
  }

  @override
  void initState() {
    super.initState();

    saveexcel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Excel Creator'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Press'),
            onPressed: () {
              anchor.click();
              Navigator.pop(context);
            },
          ),
        ));
  }
}*/
