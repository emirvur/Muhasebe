import 'package:Muhasebe/controller/irsaliyelistcontroller.dart';

import 'package:Muhasebe/models/dtoirsaliye.dart';

import 'package:Muhasebe/screen/yenisatirsa.dart';

import 'package:Muhasebe/screen/irsaliyecarisec.dart';

import 'package:Muhasebe/screen/satirs.dart';


import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Irsaliyeli extends StatefulWidget {
  @override
  _IrsaliyeliState createState() => _IrsaliyeliState();
}

class _IrsaliyeliState extends State<Irsaliyeli>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Kategori", "Stok Durumu"];
  List<Dtoirsaliye> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  DateTime today = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contara.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wdgappbar("İrsaliyeler", "", ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        /*  Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black)),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.filter_1),
                              //  iconSize: 24,
                              /*     elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),*/
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Filtrele',
                                'Kategori',
                                'Stok Durumu',
                                //  'Four'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade100,
                            height: 45,
                            child: TextField(
                              controller: contara,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () async {
                                      if (contara.text.isEmpty) {
                                        return;
                                      }
                                      setState(() {
                                        print("ilk setstateee");
                                        _isloading = true;
                                      });
                                      var value = await APIServices.satfatara(
                                          contara.text);
                                      lis = value;
                                      print("apideee");

                                      setState(() {
                                        print("ikibci setstatte");
                                        _isloading = false;
                                      });
                                    },
                                    child: Icon(Icons.search)),
                                border: OutlineInputBorder(),
                                labelText: 'Ara...',
                                hintText: 'Ara...',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Yeni Gelen Irs. oluştur'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Yenisatfatui()),
                              );
                            },
                          ),
                        ),*/
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Yeni Giden Irs. oluştur'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Yenisatirsa()),
                              ).then((e) {
                                e != 1
                                    ? print("gggg")
                                    : Get.find<Irsaliyeliscontroller>()
                                        .fetchfinaltodo();
                                /*APIServices.irsaliyeal().then((value) {
                                        setState(() {
                                          lis = value;

                                          //    _isloading = false;
                                        });
                                      });*/
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Toplu Satış Faturası oluştur'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Irsaliyecarisec()),
                              ).then((e) {
                                e != 1
                                    ? print("gggg")
                                    : Get.find<Irsaliyeliscontroller>()
                                        .fetchfinaltodo();
                                /*APIServices.odefatal().then((value) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              lis = value;

                                              //    _isloading = false;
                                            });
                                          });
                                        });*/
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: wsize.width,
                      child: Obx(() {
                        if (Get.find<Irsaliyeliscontroller>().isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DataTable(
                            showCheckboxColumn: false,
                            columns: <DataColumn>[
                              /*    DataColumn(
                                label:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),*/
                              DataColumn(
                                label: Text(
                                  'Irsaliye Açıklaması',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .grey //fontStyle: FontStyle.italic
                                      ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Tarih',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .grey //fontStyle: FontStyle.italic
                                      ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Genel Toplam',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .teal //fontStyle: FontStyle.italic
                                        ),
                                  ),
                                ),
                              ),
                            ],
                            rows: Get.find<Irsaliyeliscontroller>().sira != 0
                                ? lis
                                    .map((e) => DataRow(
                                            onSelectChanged: (bool b) {
                                              if (b) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Satirs(e)),
                                                );
                                              }
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            cells: [
                                              /*   DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),*/
                                              DataCell(InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Satirs(e)),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          e.aciklama.toString(),
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(e.cariad,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
                                                      )
                                                    ],
                                                  ))),
                                              DataCell(Text(e.tarih.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15))),
                                              DataCell(Text(
                                                  Load.numfor.format(
                                                      e.geneltop.round()),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15))),
                                            ]))
                                    .toList()
                                : Get.find<Irsaliyeliscontroller>()
                                    .listdtofatta
                                    .map((e) => DataRow(
                                            onSelectChanged: (bool b) {
                                              if (b) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Satirs(e)),
                                                );
                                              }
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            cells: [
                                              /*   DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),*/
                                              DataCell(InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Satirs(e)),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          e.aciklama.toString(),
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(e.cariad,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
                                                      )
                                                    ],
                                                  ))),
                                              DataCell(Text(e.tarih.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15))),
                                              DataCell(Text(
                                                  Load.numfor.format(
                                                      e.geneltop.round()),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15))),
                                            ]))
                                    .toList());
                      }))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
