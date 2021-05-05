import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/musteridetay.dart';
import 'package:Muhasebe/ui/tedardetay.dart';
import 'package:Muhasebe/ui/yenitedarikci.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Tedarikciiste extends StatefulWidget {
  @override
  _TedarikciisteState createState() => _TedarikciisteState();
}

class _TedarikciisteState extends State<Tedarikciiste>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Kategori", "Bakiye(Azdan çoğa)", "Bakiye(Çoktan aza)"];
  List<Dtocarilist> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
    APIServices.tedaral().then((value) {
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

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("", "Tedarikçiler", "Ahmet Seç")),
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
                                  if (newValue == "Bakiye(Azdan çoğa)") {
                                    APIServices.tedaralac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  } else if (newValue == 'Bakiye(Çoktan aza)') {
                                    APIServices.tedaralca().then((value) {
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
                                  "Bakiye(Azdan çoğa)", "Bakiye(Çoktan aza)"
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
                                        var value = await APIServices.tedara(
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
                              child: Text('Yeni Tedarikçi Oluştur'),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Yenited()))
                                    .then((value) {
                                  value == 1
                                      ? APIServices.tedaral().then((value) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              print("aaaa");
                                              lis = value;
                                              //        _isloading = false;
                                            });
                                          });
                                        })
                                      : print("aa");
                                });
                                ;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: wsize.width,
                        child: DataTable(
                            //       columnSpacing: 300,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade200),
                            columns: <DataColumn>[
                              /*   DataColumn(
                                label:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),*/
                              DataColumn(
                                label: Text(
                                  'Unvanı',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Bakiye',
                                  //     style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: lis
                                .map((e) => DataRow(
                                        color: MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                        cells: [
                                          /*     DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),*/
                                          DataCell(InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tedardetay(e)),
                                                ).then((value) {
                                                  value == 1
                                                      ? APIServices.tedaral()
                                                          .then((value) {
                                                          Future.delayed(
                                                              Duration(
                                                                  seconds: 1),
                                                              () {
                                                            setState(() {
                                                              print("aaaa");
                                                              lis = value;
                                                              //        _isloading = false;
                                                            });
                                                          });
                                                        })
                                                      : print("aa");
                                                });
                                                ;
                                              },
                                              child: Text(
                                                  e.cariunvani.toString()))),
                                          DataCell(Text(
                                            e.bakiye.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
