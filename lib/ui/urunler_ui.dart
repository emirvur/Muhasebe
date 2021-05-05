import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/addproduct_ui.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satfatrapor.dart';
import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:Muhasebe/ui/stokgecmisiui.dart';
import 'package:Muhasebe/ui/stokrapor.dart';
import 'package:Muhasebe/ui/tedarikcilist.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/excel.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'alfatrapor.dart';
import 'alisfatlist.dart';
import 'gunceldurum.dart';
import 'irsaliyelist.dart';
import 'musteriliste.dart';

class UrunlerUi extends StatefulWidget {
  @override
  _UrunlerUiState createState() => _UrunlerUiState();
}

class _UrunlerUiState extends State<UrunlerUi>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = [
    "Kategori",
    "Stok Durumu(Çoktan aza)",
    "Stok Durumu(Azdan çoğa)"
  ];
  List<Dtourun> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ewfsdds");
    contara = TextEditingController();
    APIServices.urunal().then((value) {
      setState(() {
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

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /*  appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("", "Hizmet ve Ürünler ", "Ahmet Seç")),
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
                                  if (newValue == 'Stok Durumu(Azdan çoğa)') {
                                    APIServices.urunalazdancoga().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue ==
                                      'Stok Durumu(Çoktan aza)') {
                                    APIServices.urunalcoktanaza().then((value) {
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
                                  'Stok Durumu(Çoktan aza)',
                                  'Stok Durumu(Azdan çoğa)'
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
                                        var value = await APIServices.urunara(
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            height: 45,
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              child: Text('Ürün Ekle'),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddProdForm())).then((e) {
                                  e == null
                                      ? print("gggg")
                                      : setState(() {
                                          lis.add(e);
                                          print(lis.length.toString());
                                        });
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
                              child: DataTable(
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
                                            color: Colors.teal, fontSize: 16),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Stok Miktarı',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Alış(Vergiler Hariç)',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Satış(Vergiler Hariç)',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                  rows: lis
                                      .map((e) => DataRow(
                                              color: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => Colors.white),
                                              cells: [
                                                /*   DataCell(Checkbox(
                                                    value: true,
                                                    onChanged: (b) {},
                                                  )),*/
                                                DataCell(InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProdDetailui(
                                                                    e)),
                                                      );
                                                    },
                                                    child: Text(
                                                      e.adi.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ))),
                                                DataCell(RichText(
                                                  text: TextSpan(
                                                    text: e.adet.toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: e.birim,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)
                                                          //       fontWeight:
                                                          //              FontWeight.w300)
                                                          ),
                                                    ],
                                                  ),
                                                )),
                                                DataCell(Text(
                                                  e.verharal.toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                                DataCell(Text(
                                                  e.verharsat.toString(),
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )),
                                              ]))
                                      .toList())),
                        ),
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
