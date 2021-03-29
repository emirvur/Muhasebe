//My answer is a variant on Yonkee above specifically for flutter web. In this answer, I have added the imports required (dart:html and dart:typed_data) and added formatting of text as I needed that feature.

/*
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:io';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class PDFSave extends StatefulWidget {
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

  saveexcel() async {
    /* excel.encode().then((onValue) {
      File(join("Path_to_destination/excel.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });*/
    final Workbook workbook = new Workbook();
//Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];
//Setting value in the cell
    sheet.getRangeByName('A1').setNumber(22);
    sheet.getRangeByName('A2').setNumber(44);

//Formula calculation is enabled for the sheet
    sheet.enableSheetCalculations();

//Setting formula in the cell
    sheet.getRangeByName('A3').setFormula('=A1+A2');

// Save the document.
    List<int> bytes = workbook.saveAsStream();

    final blob = html.Blob([bytes], 'application/excel');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor1 = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'excel.xlsx';
    html.document.body.children.add(anchor1);
  }

  createPDF() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Hello World', style: pw.TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
    savePDF();
  }

  /* createexcel() {
    excel = Excel.createExcel();
    Sheet sheetObject = excel['SheetName'];

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;

    // printing cell-type
    print("CellType: " + cell.cellType.toString());

    sheetObject.insertColumn(8);
  }*/

  @override
  void initState() {
    super.initState();
    createPDF();
    saveexcel();
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
              anchor1.click();
              Navigator.pop(context);
            },
          ),
        ));
  }
}*/
