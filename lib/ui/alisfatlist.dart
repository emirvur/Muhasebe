import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satisfat_detay_ui.dart';
import 'package:Muhasebe/ui/yenialisfat.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'alisdetayui.dart';

class Alisfatlist extends StatefulWidget {
  @override
  _AlisfatlistState createState() => _AlisfatlistState();
}

class _AlisfatlistState extends State<Alisfatlist>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Kategori", "Stok Durumu"];
  List<Dtofatode> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
    APIServices.odefatal().then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          print("qqq");
          lis = value;
          print("rrr");
          _isloading = false;
          print("ccc");
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contara.dispose();
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
            title: Wdgappbar("", "Giderler", "Ahmet Seç")),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
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
                                        var value =
                                            await APIServices.alisfatara(
                                                contara.text);
                                        lis = value;
                                        print("apideee");
                                        Future.delayed(
                                            Duration(seconds: 2), () {});
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
                              child: Text('Detaylı Fatura oluştur'),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Yenialisfatui()),
                                ).then((e) {
                                  e != 1
                                      ? print("gggg")
                                      : APIServices.odefatal().then((value) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              lis = value;

                                              //    _isloading = false;
                                            });
                                          });
                                        });

                                  // setState(() {
                                  //   lis.add(e);
                                  //     print(lis.length.toString());
                                  //     });
                                  /*         setState(() {
                                    print("ee");
                                    _isloading = true;
                                  });
                                  setState(() async {
                                    await APIServices.urunal();
                                    _isloading = false;
                                  });*/
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: wsize,
                        child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fatura Açıklaması',
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
                                  'Düzenleme Tarihi',
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
                                    'Kalan Meblağ',
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
                            rows: lis
                                .map((e) => DataRow(
                                        color: MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                        cells: [
                                          DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),
                                          DataCell(InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AlisfatDetailui(e)),
                                              ).then((e) {
                                                e != 1
                                                    ? print("gggg")
                                                    : APIServices.odefatal()
                                                        .then((value) {
                                                        Future.delayed(
                                                            Duration(
                                                                seconds: 1),
                                                            () {
                                                          setState(() {
                                                            lis = value;

                                                            //    _isloading = false;
                                                          });
                                                        });
                                                      });

                                                // setState(() {
                                                //   lis.add(e);
                                                //     print(lis.length.toString());
                                                //     });
                                                /*         setState(() {
                                    print("ee");
                                    _isloading = true;
                                  });
                                  setState(() async {
                                    await APIServices.urunal();
                                    _isloading = false;
                                  });*/
                                              });
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                e.fataciklama.toString(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          )),
                                          DataCell(Text(e.duztarih.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15))),
                                          DataCell(Column(
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    e.geneltoplam -
                                                                e.odendimik !=
                                                            0
                                                        ? "${e.odendimik}"
                                                        : "Ödendi",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15)),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    "Genel Toplam ${e.geneltoplam}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15)),
                                              ),
                                            ],
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
