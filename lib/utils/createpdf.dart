//My answer is a variant on Yonkee above specifically for flutter web. In this answer, I have added the imports required (dart:html and dart:typed_data) and added formatting of text as I needed that feature.
/*
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:io';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class PDFSave extends StatefulWidget {
  final Dtofattahs dto;
  final List<Dtourunhareket> lis;
  PDFSave(this.dto, this.lis);
  @override
  _PDFSaveState createState() => _PDFSaveState();
}

class _PDFSaveState extends State<PDFSave> {
  final pdf = pw.Document();
  var anchor;
  var anchor1;
  // var excel;

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';
    html.document.body.children.add(anchor);
  }

  /*createPDF() async {
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Column(children: [
        pw.Row(children: [
          pw.Text('Buse Tekstil', style: pw.TextStyle(fontSize: 18)),
          pw.Text(DateTime.now().toString(), style: pw.TextStyle(fontSize: 18)),
        ]),
        pw.Table(children: [
          pw.TableRow(children: [
            pw.Text(
              "Ürün adi",
              textScaleFactor: 1.5,
            ),
            pw.Text("Birim fiyat", textScaleFactor: 1.5),
            pw.Text("Miktar", textScaleFactor: 1.5),
            pw.Text("Vergi", textScaleFactor: 1.5),
          ]),
        ]),
        pw.ListView.builder(
          itemCount: widget.lis.length,
          itemBuilder: (context, index) {
            return pw.Table(children: [
              pw.TableRow(children: [
                pw.Text(widget.lis[index].ad, textScaleFactor: 1.5),
                pw.Text(widget.lis[index].brfiyat.toString(),
                    textScaleFactor: 1.5),
                pw.Text(widget.lis[index].miktar.toString(),
                    textScaleFactor: 1.5),
                pw.Text(widget.lis[index].vergi.toString(),
                    textScaleFactor: 1.5),
              ]),
            ]);
          },
        ),
      ]),
    ));
    savePDF();
  }*/

  createPDF1() async {
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Row(children: [
                pw.Text("Buse Tekstil"),
                pw.Text(DateTime.now().toString())
              ]),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['Urun Adi', 'Birim Fiyat', 'Miktar', 'Vergi'],
                ...widget.lis.map((msg) => [
                      msg.ad,
                      msg.brfiyat.toString(),
                      msg.miktar.toString(),
                      msg.vergi.toString()
                    ]),
              ])
            ])));
    savePDF();
  }

  @override
  void initState() {
    super.initState();
    createPDF1();
    //  saveexcel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('PDF Creator'),
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
}
*/