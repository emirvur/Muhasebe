import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/stokrapor.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
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
  Stokrapor st;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIServices.stokraporal().then((value) {
      st = value;
    });
    APIServices.urunal().then((value) {
      Future.delayed(Duration(seconds: 2), () {
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
        backgroundColor: Colors.grey.shade200,
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
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KasaListesiui()),
                              );
                            },
                            child: Text(
                              "Stoktaki Ürünler Raporu",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),

                          //   SizedBox(
                          //       width: 13,  ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Yenikasaui()),
                                );
                              },
                              child: Text(
                                "Ahmet Seç",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Stok Değeri",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${st.tahsat} TL" ?? "",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Text("Tahmini Satış Değeri")
                                    ],
                                  ),
                                  VerticalDivider(
                                    thickness: 4,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${st.tahalis} TL" ?? "",
                                          style: TextStyle(color: Colors.red)),
                                      Text("Tahmini Alış Değeri")
                                    ],
                                  ),
                                  VerticalDivider(
                                    thickness: 4,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${st.tahsat - st.tahalis} TL" ?? "",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      Text("Potansiyel Kazanç")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Tahmini Satış Değeri, Tahmini Alış Değeri ve Potansiyel Kazanç hesaplamalarına stokta olmayan ürünler dahil edilmez.Hesaplamalar ürün sayfalarında belirtilen Alış Fiyatı ve Satış Fiyatı üzerinden yapılır."),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: wsize,
                      color: Colors.white,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Tüm Ürünler",
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                    ),
                    Container(
                        width: wsize,
                        child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Ürün Adı ve Kodu',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Stok Miktarı',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Alış Fiyatı',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Satış Fiyatı',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Stok Maliyeti',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Satış Değeri',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Satış Karı',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: lis
                                .map((e) => DataRow(cells: [
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
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: e.barkodno.toString(),
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
                                          style: TextStyle(color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: e.birim,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      )),
                                      DataCell(Text(
                                        e.verharal.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        e.verharsat.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        "${e.adet * e.verharal}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        "${e.adet * e.verharsat}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        "${(e.adet * e.verharsat) - (e.adet * e.verharal)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ]))
                                .toList())),
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
