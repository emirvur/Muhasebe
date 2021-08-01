import 'package:Muhasebe/controller/degisiklik.dart';
import 'package:Muhasebe/controller/satisfatcontroller.dart';
import 'package:Muhasebe/controller/uruncontroller.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/screen/urunayrinti.dart';
import 'package:Muhasebe/screen/yeniurun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/urunayr.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/excel.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class Urunli extends StatefulWidget {
  @override
  _UrunliState createState() => _UrunliState();
}

class _UrunliState extends State<Urunli> with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Stok Durumu(Çoktan aza)", "Stok Durumu(Azdan çoğa)"];
  List<Dtourun> lis = [];
  bool _isloading = true;
  bool isara = false;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ewfsdds");
    contara = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contara.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, List<int> bytes) {
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
            print(bytes.length.toString());
            anchorexcel(bytes, "urun");
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

  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.klonmuh.muhmobil';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    print("urunlist buildde");
    final wsize = MediaQuery.of(context).size;
    print(wsize.width.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: wsize.width > 480
            ? Row(
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
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Wdgappbar("", "Hizmet ve Ürünler", ""),
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
                                    icon: Icon(
                                      FontAwesomeIcons.filter,
                                      size: 18,
                                    ),
                                    //  iconSize: 24,
                                    /*     elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),*/
                                    onChanged: (String newValue) {
                                      if (newValue ==
                                          'Stok Durumu(Azdan çoğa)') {
                                        Get.find<Urunliscontroller>()
                                            .sirafiltre(2)
                                            .then((value) {
                                          APIServices.urunalazdancoga()
                                              .then((value) {
                                            setState(() {
                                              dropdownValue = newValue;
                                              lis = value;
                                              _isloading = false;
                                            });
                                          });
                                        });
                                      } else if (newValue ==
                                          'Stok Durumu(Çoktan aza)') {
                                        Get.find<Urunliscontroller>()
                                            .sirafiltre(2)
                                            .then((value) {
                                          APIServices.urunalcoktanaza()
                                              .then((value) {
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

                                      'Stok Durumu(Çoktan aza)',
                                      'Stok Durumu(Azdan çoğa)'
                                      //  'Four'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                            if (Get.find<Urunliscontroller>()
                                                    .sira ==
                                                0) {
                                              setState(() {
                                                print("ilk setstateee");
                                                _isloading = true;
                                              });
                                              var value =
                                                  await APIServices.urunara(
                                                      contara.text);
                                              lis = value;
                                              print("apideee");
                                              Get.find<Urunliscontroller>()
                                                  .siradegistir(1)
                                                  .then((value) {
                                                setState(() {
                                                  print("ikibci setstatte");
                                                  _isloading = false;
                                                });
                                              });
                                            } else {
                                              Get.find<Urunliscontroller>()
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
                                            /*   Get.find<Urunliscontroller>().sira == 1
                                          ? setState(() {
                                        print("ilk setstateee");
                                        _isloading = true;
                                      });
                                      var value = await APIServices.urunara(
                                          contara.text);
                                      lis = value;
                                      print("apideee");
                                      Get.find<Urunliscontroller>()
                                          .siradegistir(1)
                                          .then((value) {
                                        setState(() {
                                          print("ikibci setstatte");
                                          _isloading = false;
                                        });
                                      });
                                          : Get.find<Urunliscontroller>()
                                          .siradegistir(0)
                                          .then((value) {
                                        setState(() {
                                          print("ikibci setstatte");
                                          _isloading = false;
                                        });
                                      });
*/
                                          },
                                          child: Icon(
                                            Get.find<Urunliscontroller>()
                                                        .sira ==
                                                    0
                                                ? FontAwesomeIcons.search
                                                : Get.find<Urunliscontroller>()
                                                            .sira ==
                                                        1
                                                    ? Icons.close
                                                    : Icons.search,
                                            size: 18,
                                          )),
                                      border: OutlineInputBorder(),
                                      labelText: 'Ara...',
                                      hintText: 'Ara...',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4)),
                                height: 45,
                                margin: EdgeInsets.all(20),
                                child: FlatButton(
                                  child: Text('Ürün Ekle'),
                                  color: Colors.grey.shade700,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Get.find<Degisiklikcontroller>()
                                        .siradegistir(true);
                                    //         Get.find<Satisfatcontroller>().siradegistir(0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Yeniurun()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: //Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(4)),
                              // padding: const EdgeInsets.all(8.0),
                              //width: wsize,
                              //   height: 400,
                              //  child:
                              Scrollbar(
                            isAlwaysShown: true,
                            child: SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Container(

                                    //  height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.all(8.0),
                                    width: wsize.width,
                                    child: Obx(() {
                                      if (Get.find<Urunliscontroller>()
                                          .isLoading
                                          .value) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return DataTable(
                                          showCheckboxColumn: false,
                                          //   showCheckboxColumn: true,
                                          //     dataRowHeight: 40,
                                          //     headingRowHeight: 60,
                                          //   headingRowColor: MaterialStateColor.resolveWith(
                                          //         (states) => Colors.blue),
                                          columns: <DataColumn>[
                                            /*     DataColumn(
                                        label:
                                            Checkbox(value: false, onChanged: (b) {}),
                                      ),*/
                                            DataColumn(
                                              label: Text(
                                                'Adı',
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Stok Miktarı',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Alış(Vergiler Hariç)',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Satış(Vergiler Hariç)',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                          rows: Get.find<Urunliscontroller>()
                                                      .sira !=
                                                  0
                                              ? lis
                                                  .map((e) => DataRow(
                                                          onSelectChanged:
                                                              (bool b) {
                                                            if (b) {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        Urunayr(
                                                                            e)),
                                                              );
                                                            }
                                                          },
                                                          color: MaterialStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                                      Colors
                                                                          .white),
                                                          cells: [
                                                            /*   DataCell(Checkbox(
                                                    value: true,
                                                    onChanged: (b) {},
                                                  )),*/
                                                            DataCell(InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Urunayr(e)),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  e.adi
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ))),
                                                            DataCell(RichText(
                                                              text: TextSpan(
                                                                text: e.adet
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text: e
                                                                          .birim,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey)
                                                                      //       fontWeight:
                                                                      //              FontWeight.w300)
                                                                      ),
                                                                ],
                                                              ),
                                                            )),
                                                            DataCell(Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  Load.numfor
                                                                      .format(e
                                                                          .verharal),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Icon(
                                                                    FontAwesomeIcons
                                                                        .liraSign,
                                                                    size: 18)
                                                              ],
                                                            )),
                                                            DataCell(Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  Load.numfor
                                                                      .format(e
                                                                          .verharsat),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .liraSign,
                                                                  size: 18,
                                                                  //   color: Colors.black,
                                                                )
                                                              ],
                                                            )),
                                                          ]))
                                                  .toList()
                                              : Get.find<Urunliscontroller>()
                                                  .listdtofatta
                                                  .map((e) => DataRow(
                                                          onSelectChanged:
                                                              (bool b) {
                                                            if (b) {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        Urunayr(
                                                                            e)),
                                                              );
                                                            }
                                                          },
                                                          color: MaterialStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                                      Colors
                                                                          .white),
                                                          cells: [
                                                            /*   DataCell(Checkbox(
                                                    value: true,
                                                    onChanged: (b) {},
                                                  )),*/
                                                            DataCell(InkWell(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Urunayr(e)),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  e.adi
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ))),
                                                            DataCell(RichText(
                                                              text: TextSpan(
                                                                text: e.adet
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                      text: e
                                                                          .birim,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey)
                                                                      //       fontWeight:
                                                                      //              FontWeight.w300)
                                                                      ),
                                                                ],
                                                              ),
                                                            )),
                                                            DataCell(Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  Load.numfor
                                                                      .format(e
                                                                          .verharal),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Icon(
                                                                    FontAwesomeIcons
                                                                        .liraSign,
                                                                    size: 12)
                                                              ],
                                                            )),
                                                            DataCell(Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  Load.numfor
                                                                      .format(e
                                                                          .verharsat),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .liraSign,
                                                                  size: 12,
                                                                  //   color: Colors.black,
                                                                )
                                                              ],
                                                            )),
                                                          ]))
                                                  .toList());
                                    }))),
                          ),
                          //   ),
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
                                    createexcel(Get.find<Urunliscontroller>()
                                            .listdtofatta)
                                        .then((value) {
                                      print("11");
                                      setState(() {
                                        _isloading = false;
                                        print(value.length.toString());
                                        showAlertDialog(context, value);
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.import_export),
                                  label: Text("Excel'e Aktar"))),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Responsive tasarım çok yakında..."),
                  Text(
                      "Mobil uygulamadan işlemlerinizi gerçekleştirebilirsiniz"),
                  ElevatedButton(
                      onPressed: _launchURL, child: Text("Uygulamaya git"))
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
