import 'package:Muhasebe/models/dtostokgecmisi.dart';

import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/ui/satisfaticinurun.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
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
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("", "Stok Geçmişi", "Ahmet Seç")),
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
                    Container(
                        width: wsize,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade200),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Ürün ',
                                  style: TextStyle(
                                      //fontStyle: FontStyle.italic
                                      color: Colors.grey),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Miktar',
                                  style: TextStyle(
                                      //fontStyle:FontStyle.italic
                                      color: Colors.grey),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Hareket Yönü',
                                  style: TextStyle(
                                      //fontStyle: FontStyle.italic
                                      color: Colors.grey),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Müşteri/Tedarikçi',
                                  style: TextStyle(
                                      //fontStyle: FontStyle.italic
                                      color: Colors.grey),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Hareket Tarihi',
                                  style: TextStyle(
                                      //fontStyle: FontStyle.italic
                                      color: Colors.grey),
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
                                                //     e.fattur==1?
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Satfatdetailicinurun(
                                                              e.fatid)),
                                                );
                                              },
                                              child:
                                                  Text(e.urunad.toString()))),
                                          DataCell(Text(e.miktar.toString(),
                                              style: TextStyle(
                                                  //    fontWeight: FontWeight.bold
                                                  ))),
                                          DataCell(Text(
                                            e.fattur,
                                            style: TextStyle(
                                                //  fontWeight: FontWeight.bold
                                                ),
                                          )),
                                          DataCell(Text(
                                            e.cariad.toString(),
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold
                                                ),
                                          )),
                                          DataCell(Text(
                                            e.duzenlemetarih.toString(),
                                            style: TextStyle(
                                                //  fontWeight: FontWeight.bold
                                                ),
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
