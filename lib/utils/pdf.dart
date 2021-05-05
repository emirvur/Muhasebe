import 'dart:typed_data';

import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'dart:html' as html;

Future<pw.Document> createPDF1(
    String ad, String duztar, dynamic lis, List<dynamic> lis1) async {
  final pdf = pw.Document();
  if (lis is Dtofattahs) {
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(children: [
                      pw.Text("Ilgili Firma:"),
                      pw.Text(ad),
                    ]),
                    pw.Column(children: [
                      pw.Text("Duzenleme Tarihi:"),
                      pw.Text(duztar),
                    ]),
                  ]),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['Urun Adi', 'Birim Fiyat', 'Miktar', 'Vergi'],
                ...lis1.map((msg) => [
                      msg.ad,
                      msg.brfiyat.toString(),
                      msg.miktar.toString(),
                      msg.vergi.toString()
                    ]),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text("Tahsil edilen miktar:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(lis.alinmism.toString(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
              ]),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text("Genel Toplam:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(lis.geneltoplam.toString(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
              ]),
            ])));
    return pdf;
  } else if (lis is Dtofatode) {
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(children: [
                      pw.Text("Ilgili Firma:"),
                      pw.Text(ad),
                    ]),
                    pw.Column(children: [
                      pw.Text("Duzenleme Tarihi:"),
                      pw.Text(duztar),
                    ]),
                  ]),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['Urun Adi', 'Birim Fiyat', 'Miktar', 'Vergi'],
                ...lis1.map((msg) => [
                      msg.ad,
                      msg.brfiyat.toString(),
                      msg.miktar.toString(),
                      msg.vergi.toString()
                    ]),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text("Odenen miktar:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(lis.odendimik.toString(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
              ]),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text("Genel Toplam:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(lis.geneltoplam.toString(),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
              ]),
            ])));
    return pdf;
  } else if (lis1 is List<Dtofattahs>) {
    pdf.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(children: [
                      pw.Text("Ilgili Firma:"),
                      pw.Text(ad),
                    ]),
                    pw.Column(children: [
                      pw.Text("Bakiye:"),
                      pw.Text(lis.bakiye.toString()),
                    ]),
                  ]),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  'Fatura aciklamasi',
                  'Duzenleme Tarihi',
                  'Vade Tarihi',
                  'Kalan Meblag'
                ],
                ...lis1.map((msg) => [
                      "q" //msg.fataciklama,
                          "f" // msg.duztarih.toString(),
                          "d" //   msg.vadta.toString(),
                          "" //   "${msg.geneltoplam - msg.alinmism}" //  msg.vergi.toString()
                    ]),
              ]),
              pw.Text("ytfhgfgf")
            ])));
    return pdf;
  } else if (lis is List<Dtofattahs>) {
    return pdf;
  }
}

anchorpdf(pw.Document pdf, String ad) async {
/*  var anchor;
  Uint8List pdfInBytes = await pdf.save();
  final blob = html.Blob([pdfInBytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = '${ad}pdf.pdf';
  html.document.body.children.add(anchor);
  anchor.click();*/
}
