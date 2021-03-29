import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasaharui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
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
                          Text(
                            "Kasa ve Bankalar",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),

                          //   SizedBox(
                          //       width: 13,  ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Yenikasaui()),
                                );
                              },
                              child: Text(
                                "Ahmet Seç",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            height: 45,
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              child: Text('Kasa Ekle'),
                              color: Colors.grey,
                              textColor: Colors.white,
                              onPressed: () {
                                print("kasa ekleye basildi");
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              child: Text('Banka Ekle'),
                              color: Colors.blueAccent,
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
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Kasa ismi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Iban',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Bakiye',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: lis
                                .map((e) => DataRow(cells: [
                                      DataCell(InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Kasaharui(e)),
                                            );
                                          },
                                          child: Text(e.kasaAd.toString()))),
                                      DataCell(Text("-")),
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
