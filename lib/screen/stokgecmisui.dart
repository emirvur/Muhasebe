import 'package:Muhasebe/controller/stgecmiscontroller.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/screen/alisfatayrintiurun.dart';
import 'package:Muhasebe/screen/satfatayrintiurun.dart';

import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/screen/satisfaticinurun.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Stokgecmisui extends StatefulWidget {
  @override
  _StokgecmisuiState createState() => _StokgecmisuiState();
}

class _StokgecmisuiState extends State<Stokgecmisui>
    with AutomaticKeepAliveClientMixin {
  List<Dtostokgecmisi> lis = [];
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                child: Wdgdrawer()),
            Obx(() {
              if (Get.find<Stgecmiscontroller>().isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  //   child: Expanded(
                  child: Column(
                    children: [
                      Wdgappbar("Stok Geçmişi", "", ""),
                      Container(
                          width: wsize.width,
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
                              rows: Get.find<Stgecmiscontroller>()
                                  .listdtofatta
                                  .map((e) => DataRow(
                                          color: MaterialStateColor.resolveWith(
                                              (states) => Colors.white),
                                          cells: [
                                            DataCell(InkWell(
                                                /*     onTap: () {
                                                  e.fattur == "Stok Çıkış"
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Satfatayrintiurun(
                                                                      e.fatid)),
                                                        )
                                                      : Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Alisfatayrintiurun(
                                                                      e.fatid)));
                                                },*/
                                                child:
                                                    Text(e.urunad.toString()))),
                                            DataCell(Text(e.miktar.toString(),
                                                style: TextStyle(
                                                    //    fontWeight: FontWeight.bold
                                                    ))),
                                            DataCell(Text(
                                              e.cariad == null
                                                  ? "irsaliye"
                                                  : e.fattur,
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
                                              e.cariad == null
                                                  ? "irsaliye"
                                                  : e.duzenlemetarih.toString(),
                                              style: TextStyle(
                                                  //  fontWeight: FontWeight.bold
                                                  ),
                                            )),
                                          ]))
                                  .toList())),
                    ],
                  ),
                  //   ),
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
