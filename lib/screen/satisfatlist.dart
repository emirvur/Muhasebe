import 'package:Muhasebe/controller/satisfatcontroller.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/screen/satisfatayrinti.dart';
import 'package:Muhasebe/screen/yenisatfat.dart';
import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/excel.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Satisfatli extends StatefulWidget {
  @override
  _SatisfatliState createState() => _SatisfatliState();
}

class _SatisfatliState extends State<Satisfatli>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = [
    "Kategori",
    "Tahsil edilmiş",
    "Açık Fatura",
    "Düzenleme Tarihi(Yeniden eskiye)",
    "Düzenleme Tarihi(Eskiden yeniye)",
    "Vade Tarihi(Yeniden eskiye)",
    "Vade Tarihi(Eskiden yeniye)"
  ];
  List<Dtofattahs> lis = [];
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

  String fonk(Dtofattahs x) {
    print("111");
    DateTime far;
    if (x.vadta != "null") {
      print("yyy");
      //     print(dt.vadta);
      print("ooo");
      //       print(dt.vadta);
      int yil = int.tryParse(x.vadta.substring(0, 4));
      print(yil.toString());
      int ay = int.tryParse(x.vadta.substring(5, 7));
      print(ay.toString());
      int gun = int.tryParse(x.vadta.substring(8, 10));
      print(gun.toString());

      far = DateTime(yil, ay, gun);
      if (DateTime.now().difference(far).inDays.sign == 0) {
        return "Bugün";
      } else if (DateTime.now().difference(far).inDays.sign == -1) {
        return x.vadta;
      } else {
        return "${DateTime.now().difference(far).inDays.toString()} gün gecikti";
      }
    } else {
      far = DateTime(2000, 1, 1);
      return DateTime.now().difference(far).inDays.toString();
    }
  }

  showAlertDialog(BuildContext context, List<int> bytes) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Simple Alert"),
      content: Text("Excel dosyası indirme"),
      actions: [
        FlatButton(
          child: Text("İptal"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("İndir"),
          onPressed: () {
            anchorexcel(bytes, "satisfatura");
            Navigator.of(context).pop();
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    print(wsize.toString());
    print("uuu");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                child: Wdgdrawer()),
            Expanded(
              child: Column(
                children: [
                  Wdgappbar("Satışlar", "", ""),
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
                                if (newValue == "Tahsil edilmiş") {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalkapali().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue == 'Açık Fatura') {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalacikfat().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue ==
                                    'Düzenleme Tarihi(Yeniden eskiye)') {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalduzca().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue ==
                                    'Düzenleme Tarihi(Eskiden yeniye)') {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalduzac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue ==
                                    'Vade Tarihi(Yeniden eskiye)') {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalvadca().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue ==
                                    'Vade Tarihi(Eskiden yeniye)') {
                                  Get.find<Satisfatcontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.satfatalvadeac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                }
                              },
                              items: <String>[
                                'Filtrele',
                                //      'Kategori',
                                "Tahsil edilmiş",
                                "Açık Fatura",
                                "Düzenleme Tarihi(Yeniden eskiye)",
                                "Düzenleme Tarihi(Eskiden yeniye)",
                                "Vade Tarihi(Yeniden eskiye)",
                                "Vade Tarihi(Eskiden yeniye)"

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
                                      if (Get.find<Satisfatcontroller>().sira ==
                                          0) {
                                        setState(() {
                                          print("ilk setstateee");
                                          _isloading = true;
                                        });
                                        var value = await APIServices.satfatara(
                                            contara.text);
                                        lis = value;
                                        print("apideee");
                                        Get.find<Satisfatcontroller>()
                                            .siradegistir(1)
                                            .then((value) {
                                          setState(() {
                                            print("ikibci setstatte");
                                            _isloading = false;
                                          });
                                        });
                                      } else {
                                        Get.find<Satisfatcontroller>()
                                            .siradegistir(0)
                                            .then((value) {
                                          setState(() {
                                            dropdownValue = "Filtrele";
                                            contara.text = "";
                                            print("ikibci setstatte");
                                            _isloading = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Get.find<Satisfatcontroller>().sira == 0
                                          ? FontAwesomeIcons.search
                                          : Get.find<Satisfatcontroller>()
                                                      .sira ==
                                                  1
                                              ? Icons.close
                                              : Icons.search,
                                    )),
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
                            child: Text('Yeni Fatura oluştur'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Yenisatfat()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.all(8.0),
                          width: wsize.width,
                          child: Obx(() {
                            if (Get.find<Satisfatcontroller>()
                                .isLoading
                                .value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return DataTable(
                                showCheckboxColumn: false,
                                columns: <DataColumn>[
                                  /*  DataColumn(
                                          label: Checkbox(
                                              value: false, onChanged: (b) {}),
                                        ),*/
                                  DataColumn(
                                    label:
                                        /*AutoSizeText(
                                        'Fatura Açıklaması',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .grey //fontStyle: FontStyle.italic
                                            ),
                                        maxLines: 1,
                                      ),*/
                                        //      Expanded(
                                        //  child:
                                        // FittedBox(
                                        //   fit: BoxFit.fitWidth,
                                        // child:
                                        Text(
                                      'Fatura Açıklaması',
                                      style: TextStyle(
                                          fontSize: 16, //wsize > 800 ? 16 : 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .grey //fontStyle: FontStyle.italic
                                          ),

                                      // maxLines: 1,
                                    ),
                                    //  ),
                                    //    ),
                                  ),
                                  DataColumn(
                                    label: //Expanded(
                                        // child:
                                        //    FittedBox(
                                        //    fit: BoxFit.fitWidth,
                                        //child:
                                        Text(
                                      'Düzenleme Tarihi',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .grey //fontStyle: FontStyle.italic
                                          ),
                                    ),
                                    //   ),
                                    //   ),
                                  ),
                                  DataColumn(
                                    label: // Expanded(
                                        // child:
                                        //    FittedBox(
                                        //    fit: BoxFit.fitWidth,
                                        //   child:
                                        Text(
                                      'Vade Tarihi',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .grey //fontStyle: FontStyle.italic
                                          ),
                                    ),
                                    //    ),
                                    //  ),
                                  ),
                                  DataColumn(
                                    label: Align(
                                      alignment: Alignment.centerRight,
                                      //child: Expanded(
                                      //  child: FittedBox(
                                      //      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Kalan Meblağ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors
                                                .teal //fontStyle: FontStyle.italic
                                            ),
                                      ),
                                      //    ),
                                      //    ),
                                    ),
                                  ),
                                ],
                                rows: Get.find<Satisfatcontroller>().sira != 0
                                    ? lis
                                        .map((e) => DataRow(
                                                onSelectChanged: (bool b) {
                                                  if (b) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Satisfatayrinti(
                                                                  e)),
                                                    );
                                                  }
                                                },
                                                color: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.white),
                                                cells: [
                                                  /*      DataCell(Checkbox(
                                                      value: true,
                                                      onChanged: (b) {},
                                                    )),*/
                                                  DataCell(InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Satisfatayrinti(
                                                                      e)),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            //    child: FittedBox(
                                                            //    fit:
                                                            //      BoxFit.fitWidth,
                                                            child: Text(
                                                              e.fataciklama
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            //    ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                e.cariad,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15)),
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
                                                              : fonk(
                                                                  e), //e.vadta
                                                          //  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        //  child: FittedBox(
                                                        //  fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            e.geneltoplam -
                                                                        e
                                                                            .alinmism !=
                                                                    0
                                                                ? "${Load.numfor.format(e.geneltoplam.round() - e.alinmism.round())}"
                                                                : "Tahsil edildi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18)),
                                                        //       ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        //child: FittedBox(
                                                        //    fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            "Genel Toplam ${Load.numfor.format(e.geneltoplam.round())}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
                                                        //    ),
                                                      ),
                                                    ],
                                                  )),
                                                ]))
                                        .toList()
                                    : Get.find<Satisfatcontroller>()
                                        .listdtofatta
                                        .map((e) => DataRow(
                                                onSelectChanged: (bool b) {
                                                  if (b) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Satisfatayrinti(
                                                                  e)),
                                                    );
                                                  }
                                                },
                                                color: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.white),
                                                cells: [
                                                  /*      DataCell(Checkbox(
                                                      value: true,
                                                      onChanged: (b) {},
                                                    )),*/
                                                  DataCell(InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Satisfatayrinti(
                                                                      e)),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            //    child: FittedBox(
                                                            //    fit:
                                                            //      BoxFit.fitWidth,
                                                            child: Text(
                                                              e.fataciklama
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            //    ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                e.cariad,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15)),
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
                                                              : fonk(e),
                                                          //e.vadta
                                                          //  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        //  child: FittedBox(
                                                        //  fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            e.geneltoplam -
                                                                        e
                                                                            .alinmism !=
                                                                    0
                                                                ? "${Load.numfor.format(e.geneltoplam.round() - e.alinmism.round())}"
                                                                : "Tahsil edildi",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18)),
                                                        //       ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        //child: FittedBox(
                                                        //    fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            "Genel Toplam ${Load.numfor.format(e.geneltoplam.round())}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
                                                        //    ),
                                                      ),
                                                    ],
                                                  )),
                                                ]))
                                        .toList());
                          })),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                        height: 50,
                        child: TextButton.icon(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              //   onSurface: Colors.pink,
                            ),
                            onPressed: () {
                              setState(() {
                                _isloading = true;
                              });
                              createexcel(Get.find<Satisfatcontroller>()
                                      .listdtofatta)
                                  .then((value) {
                                setState(() {
                                  _isloading = false;
                                });
                                showAlertDialog(context, value);
                              });
                            },
                            icon: Icon(Icons.import_export),
                            label: Text("Excel'e Aktar"))),
                  )
                ],
              ),
            ),
            //    ),
            //    )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
