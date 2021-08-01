import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/screen/alisfatayrinti.dart';
import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Tedarodeekle extends StatefulWidget {
  final int dt;
  final String cari;
  Tedarodeekle(this.dt, this.cari);
  @override
  _TedarodeekleState createState() => _TedarodeekleState();
}

class _TedarodeekleState extends State<Tedarodeekle>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Stok Durumu"];
  List<Dtofatode> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
    APIServices.carialfatal(widget.dt).then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          print("qqq");
          lis = value;
          print("rrr");
          _isloading = false;
          print("ccc");
          //    print(lis[0].cariad);
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
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /*  appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar(widget.cari, "Giderler", "Ahmet Seç")),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wdgappbar("Tedarikçi Faturaları", "", ""),
                    ),
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
                                        var value = await APIServices.carialara(
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
                                                            Alisfatayrinti(e)),
                                                  ).then((e) {
                                                    //e != 1
                                                    //    ? print("gggg")
                                                    //      :
                                                    APIServices.carialfatal(
                                                            widget.dt)
                                                        .then((value) {
                                                      setState(() {
                                                        lis = value;

                                                        //    _isloading = false;
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    e.fataciklama.toString(),
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              )),
                                              DataCell(Text(
                                                  e.duztarih.toString(),
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
                                                                    e
                                                                        .odendimik !=
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
