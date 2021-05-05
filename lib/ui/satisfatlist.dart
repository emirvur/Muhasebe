import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satisfat_detay_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/ui/yenisatisfatui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/excel.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Satisfatlist extends StatefulWidget {
  @override
  _SatisfatlistState createState() => _SatisfatlistState();
}

class _SatisfatlistState extends State<Satisfatlist>
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
    APIServices.satfatal().then((value) {
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
    contara.dispose();
    super.dispose();
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
        /*  appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("", "Satış Faturaları ", "Ahmet Seç")),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .black87, //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(child: Wdgdrawer()),
        ),*/
        backgroundColor: Colors.grey.shade300,
        body: LoadingOverlay(
          isLoading: _isloading,
          opacity: 0,
          progressIndicator: Wdgloadingalert(wsize: wsize),
          child: Row(
            children: [
              //    Expanded(
              //    child: SingleChildScrollView(
              //    child:
              Container(
                  color: Colors.black87,
                  width: wsize.width / 5,
                  //    height: 500,
                  child: Wdgdrawer()),
              Expanded(
                child: Column(
                  children: [
                    Wdgappbar("wwww", "gggg", "qqqsw"),
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
                                    APIServices.satfatalkapali().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue == 'Açık Fatura') {
                                    APIServices.satfatalacikfat().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue ==
                                      'Düzenleme Tarihi(Yeniden eskiye)') {
                                    APIServices.satfatalduzca().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue ==
                                      'Düzenleme Tarihi(Eskiden yeniye)') {
                                    APIServices.satfatalduzac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue ==
                                      'Vade Tarihi(Yeniden eskiye)') {
                                    APIServices.satfatalvadca().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue ==
                                      'Vade Tarihi(Eskiden yeniye)') {
                                    APIServices.satfatalvadeac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  }
                                },
                                items: <String>[
                                  'Filtrele',
                                  'Kategori',
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
                                        setState(() {
                                          print("ilk setstateee");
                                          _isloading = true;
                                        });
                                        var value = await APIServices.satfatara(
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
                              child: Text('Yeni Fatura oluştur'),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Yenisatfatui()),
                                ).then((e) {
                                  e != 1
                                      ? print("gggg")
                                      : APIServices.satfatal().then((value) {
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
                              child: DataTable(
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
                                            fontSize:
                                                16, //wsize > 800 ? 16 : 12,
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
                                  rows: lis
                                      .map((e) => DataRow(
                                              color: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => Colors.white),
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
                                                                SatisfatDetailui(
                                                                    e)),
                                                      ).then((e) {
                                                        e != 1
                                                            ? print("gggg")
                                                            : APIServices
                                                                    .satfatal()
                                                                .then((value) {
                                                                Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1),
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
                                                          child: Text(e.cariad,
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
                                                            : e.vadta
                                                                .toString(),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      //  child: FittedBox(
                                                      //  fit: BoxFit.fitWidth,
                                                      child: Text(
                                                          e.geneltoplam -
                                                                      e
                                                                          .alinmism !=
                                                                  0
                                                              ? "${e.geneltoplam - e.alinmism}"
                                                              : "Tahsil edildi",
                                                          style:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18)),
                                                      //       ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      //child: FittedBox(
                                                      //    fit: BoxFit.fitWidth,
                                                      child: Text(
                                                          "Genel Toplam ${e.geneltoplam}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 15)),
                                                      //    ),
                                                    ),
                                                  ],
                                                )),
                                              ]))
                                      .toList())),
                        ),
                      ),
                    ),
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
                                createexcel(lis).then((value) {
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
