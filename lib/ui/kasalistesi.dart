import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasaharui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class KasaListesiui extends StatefulWidget {
  @override
  _KasaListesiuiState createState() => _KasaListesiuiState();
}

class _KasaListesiuiState extends State<KasaListesiui>
    with AutomaticKeepAliveClientMixin {
  List<Kasa> lis = [];
  bool _isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIServices.kasaal().then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("Kasa ve Bankalar >", "", "Ahmet Seç")),
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
                                      builder: (context) => Yenikasaui()),
                                ).then((b) {
                                  b != 1
                                      ? print("fff")
                                      : APIServices.kasaal().then((value) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              print("aaaa");
                                              lis = value;
                                              //        _isloading = false;
                                            });
                                          });
                                        });
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              child: Text('Banka Ekle'),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: wsize,
                        child: DataTable(
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
                              DataColumn(
                                label: Text(
                                  'Iban',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Bakiye',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: lis
                                .map((e) => DataRow(
                                        color: MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                        cells: [
                                          DataCell(InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Kasaharui(e)),
                                                ).then((b) {
                                                  b != 1
                                                      ? print("fff")
                                                      : APIServices.kasaal()
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
                                                        });
                                                });
                                              },
                                              child: Text(
                                                e.kasaAd.toString(),
                                                style: TextStyle(fontSize: 18),
                                              ))),
                                          DataCell(Text("-")),
                                          DataCell(Text(
                                            e.bakiye.toString(),
                                            style: TextStyle(
                                                fontSize: 15,
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
