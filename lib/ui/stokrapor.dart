import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/stokrapor.dart';

import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/ui/product_detail_ui.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Stokraporui extends StatefulWidget {
  @override
  _StokraporuiState createState() => _StokraporuiState();
}

class _StokraporuiState extends State<Stokraporui>
    with AutomaticKeepAliveClientMixin {
  List<Dtourun> lis = [];
  bool _isloading = true;
  Stokrapor st = Stokrapor(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIServices.stokraporal().then((value) {
      st = value;
    });
    APIServices.urunal().then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("", "Stoktaki Ürünler Raporu", "Ahmet Seç")),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .black87, //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(child: Wdgdrawer()),
        ),
        backgroundColor: Colors.grey.shade300,
        body: LoadingOverlay(
          isLoading: _isloading,
          opacity: 0,
          progressIndicator: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 50,
                ),
                Text("Yükleniyor...")
              ],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${st.tahsat} TL" ?? "",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${st.tahalis} TL" ?? "",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 18)),
                                      Text("Tahmini Alış Değeri",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18))
                                    ],
                                  ),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${st.tahsat - st.tahalis} TL" ?? "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)),
                                      Text("Potansiyel Kazanç",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18))
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
                        width: wsize,
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
                          width: wsize,
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
                              rows: lis
                                  .map((e) => DataRow(
                                          color: MaterialStateColor.resolveWith(
                                              (states) => Colors.white),
                                          cells: [
                                            DataCell(InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProdDetailui(e)),
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
                                                          color: Colors.black),
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
                                            DataCell(Text(
                                              e.verharal.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.verharsat.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              "${e.adet * e.verharal}",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              "${e.adet * e.verharsat}",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              "${(e.adet * e.verharsat) - (e.adet * e.verharal)}",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ]))
                                  .toList())),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
