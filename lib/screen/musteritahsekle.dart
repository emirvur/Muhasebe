import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/screen/satisfatayrinti.dart';
import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Mustahsekle extends StatefulWidget {
  final int dt;
  final String cari;
  Mustahsekle(this.dt, this.cari);
  @override
  _MustahsekleState createState() => _MustahsekleState();
}

class _MustahsekleState extends State<Mustahsekle>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Stok Durumu"];
  List<Dtofattahs> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  DateTime today = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("1");
    contara = TextEditingController();
    APIServices.carisatfatal(widget.dt).then((value) {
      setState(() {
        print("2");
        lis = value;

        _isloading = false;
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
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: LoadingOverlay(
          isLoading: _isloading,
          opacity: 0,
          progressIndicator: Wdgloadingalert(wsize: wsize),
          child: Row(
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
                      child: Wdgappbar("Müşteri Faturaları", "", ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                            await APIServices.carisatara(
                                                widget.dt, contara.text);
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
                              child: Text(''),
                              color: Colors.transparent,
                              textColor: Colors.transparent,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Container(
                            width: wsize.width,
                            child: DataTable(
                                columns: <DataColumn>[
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
                                    label: Text(
                                      'Vade Tarihi',
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
                                                              Satisfatayrinti(
                                                                  e)),
                                                    ).then((e) {
                                                      //e != 1
                                                      //      ? print("gggg")
                                                      //        :
                                                      APIServices.carisatfatal(
                                                              widget.dt)
                                                          .then((value) {
                                                        setState(() {
                                                          lis = value;
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
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          e.fataciklama
                                                              .toString(),
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
                                              DataCell(Text(
                                                  e.duztarih.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15))),
                                              DataCell(Column(
                                                children: [
                                                  Text(
                                                      e.vadta == "null"
                                                          ? e.alta
                                                          : e.vadta.toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15)),
                                                  /*       e.vadta != null
                                                          ? Text(today
                                                              .difference(
                                                                  DateTime.parse(
                                                                      e.vadta))
                                                              .inDays
                                                              .toString())
                                                          : Text("")*/
                                                ],
                                              )),
                                              DataCell(Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        e.geneltoplam -
                                                                    e
                                                                        .alinmism !=
                                                                0
                                                            ? "${e.geneltoplam - e.alinmism}"
                                                            : "Tahsil edildi",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18)),
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
                      ),
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
