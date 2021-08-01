import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/screen/kasaharekui.dart';
import 'package:Muhasebe/screen/yenikasa.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Kasali extends StatefulWidget {
  @override
  _KasaliState createState() => _KasaliState();
}

class _KasaliState extends State<Kasali> with AutomaticKeepAliveClientMixin {
  List<Kasa> lis = [];
  bool _isloading = true;
  GlobalKey _toolTipKey = GlobalKey();
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
                //    height: 500,
                child: Wdgdrawer()),
            Expanded(
              child: Column(
                children: [
                  Wdgappbar("Kasa ve Bankalar", "", ""),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Kasa Ekle'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Yenikasa()),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Tooltip(
                                key: _toolTipKey,
                                message: "Pek yakında",
                                child: Text('Banka Ekle')),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              final dynamic _toolTip = _toolTipKey.currentState;
                              _toolTip.ensureTooltipVisible();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: wsize.width,
                      child: Obx(() {
                        if (Get.find<KasaController>().isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DataTable(
                            showCheckboxColumn: false,
                            columnSpacing: 400,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Hesap ismi',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              /*   DataColumn(
                                label: Text(
                                  'Iban',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),*/
                              DataColumn(
                                label: Text(
                                  'Bakiye',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: Get.find<KasaController>()
                                .todoList
                                .map((e) => DataRow(
                                        onSelectChanged: (bool b) {
                                          if (b) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Kasaharekui(e)),
                                            );
                                          }
                                        },
                                        color: MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                        cells: [
                                          DataCell(InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Kasaharekui(e)),
                                                );
                                              },
                                              child: Text(
                                                e.kasaAd.toString(),
                                                style: TextStyle(fontSize: 18),
                                              ))),
                                          //          DataCell(Text("-")),
                                          DataCell(Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                Load.numfor
                                                    .format(e.bakiye.round()),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(FontAwesomeIcons.liraSign,
                                                  size: 12),
                                            ],
                                          )),
                                        ]))
                                .toList());
                      })),
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
