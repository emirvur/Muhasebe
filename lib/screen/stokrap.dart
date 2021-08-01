import 'package:Muhasebe/controller/degisiklik.dart';

import 'package:Muhasebe/screen/urunayr.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Stokrap extends StatefulWidget {
  @override
  _StokrapState createState() => _StokrapState();
}

class _StokrapState extends State<Stokrap> with AutomaticKeepAliveClientMixin {
  //List<Dtourun> lis = [];
  bool _isloading = true;
  // Stokrapor st = Stokrapor(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
            Obx(() {
              if (Get.find<Degisiklikcontroller>().isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wdgappbar("Stoktaki Ürünler Raporu", "", ""),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          //   color: Colors.white,
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Stok Değeri",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  )),
                              Container(
                                height: 75,
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${Load.numfor.format(Get.find<Degisiklikcontroller>().st.tahsat.round())} TL" ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 18),
                                        ),
                                        Text(
                                          "Tahmini Satış Değeri",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        )
                                      ],
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${Load.numfor.format(Get.find<Degisiklikcontroller>().st.tahalis.round())} TL" ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18)),
                                        Text("Tahmini Alış Değeri",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18))
                                      ],
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${(Load.numfor.format(Get.find<Degisiklikcontroller>().st.tahsat.round() - Get.find<Degisiklikcontroller>().st.tahalis.round()))} TL" ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18)),
                                        Text("Potansiyel Kazanç",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Tahmini Satış Değeri, Tahmini Alış Değeri ve Potansiyel Kazanç hesaplamalarına stokta olmayan ürünler dahil edilmez.Hesaplamalar ürün sayfalarında belirtilen Alış Fiyatı ve Satış Fiyatı üzerinden yapılır.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 70,
                          width: wsize.width,
                          color: Colors.white,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Tüm Ürünler",
                                  style: TextStyle(fontSize: 24),
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: wsize.width,
                            child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey.shade200),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Ürün Adı ve Kodu',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Stok Miktarı',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Alış Fiyatı',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Satış Fiyatı',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Stok Maliyeti',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Satış Değeri',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Satış Karı',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                                rows: Get.find<Degisiklikcontroller>()
                                    .listdtofatta
                                    .map((e) => DataRow(
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            cells: [
                                              DataCell(InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Urunayr(e)),
                                                  );
                                                },
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: e.adi.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: "  ${e.barkodno}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                              DataCell(RichText(
                                                text: TextSpan(
                                                  text: e.adet.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "  ${e.birim}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              DataCell(Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    Load.numfor
                                                        .format(e.verharal),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.liraSign,
                                                    size: 12,
                                                  )
                                                ],
                                              )),
                                              DataCell(Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    Load.numfor
                                                        .format(e.verharsat),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.liraSign,
                                                    size: 12,
                                                  )
                                                ],
                                              )),
                                              DataCell(Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    Load.numfor.format(
                                                        (e.adet * e.verharal)
                                                            .round()),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.liraSign,
                                                    size: 12,
                                                  )
                                                ],
                                              )),
                                              DataCell(Text(
                                                Load.numfor.format(
                                                    (e.adet * e.verharsat)
                                                        .round()),
                                                style: TextStyle(fontSize: 15),
                                              )),
                                              DataCell(Text(
                                                Load.numfor.format(
                                                    (e.adet * e.verharsat)
                                                            .round() -
                                                        (e.adet * e.verharal)
                                                            .round()),
                                                style: TextStyle(fontSize: 15),
                                              )),
                                            ]))
                                    .toList())),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
