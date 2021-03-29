import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satisfat_detay_ui.dart';
import 'package:Muhasebe/ui/satisfaticinurun.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Stokgecmisiui extends StatefulWidget {
  @override
  _StokgecmisiuiState createState() => _StokgecmisiuiState();
}

class _StokgecmisiuiState extends State<Stokgecmisiui>
    with AutomaticKeepAliveClientMixin {
  List<Dtostokgecmisi> lis = [];
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    APIServices.urungenelgecmisial().then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
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
                              /*    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SatisfatDetailui()),
                              );*/
                            },
                            child: Text(
                              "Stok Geçmişi",
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
                    Container(
                        width: wsize,
                        child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Ürün ',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Miktar',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Hareket Yönü',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Müşteri/Tedarikçi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Hareket Tarihi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: lis
                                .map((e) => DataRow(cells: [
                                      DataCell(InkWell(
                                          onTap: () {
                                            //     e.fattur==1?
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SatisfatDetailicinurun(
                                                          e.fatid)),
                                            );
                                          },
                                          child: Text(e.urunad.toString()))),
                                      DataCell(Text(
                                        e.miktar.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        e.fattur,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        e.cariad.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        e.duzenlemetarih.toString(),
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
