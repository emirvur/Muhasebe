import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satisfat_detay_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Satisfatlist extends StatefulWidget {
  @override
  _SatisfatlistState createState() => _SatisfatlistState();
}

class _SatisfatlistState extends State<Satisfatlist>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Kategori", "Stok Durumu"];
  List<Dtofattahs> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
    APIServices.satfatal().then((value) {
      Future.delayed(Duration(seconds: 2), () {
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
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KasaListesiui()),
                              );
                            },
                            child: Text(
                              "Satış Faturaları",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
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
                          Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
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
                                  labelText: 'Ara',
                                  hintText: 'Ara',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            margin: EdgeInsets.all(20),
                            child: FlatButton(
                              child: Text('Yeni Fatura oluştur'),
                              color: Colors.grey,
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
                                  'Fatura Açıklaması',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Düzenleme Tarihi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Vade Tarihi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Kalan Meblağ',
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
                                                      SatisfatDetailui(e)),
                                            );
                                          },
                                          child:
                                              Text(e.fataciklama.toString()))),
                                      DataCell(Text(
                                        e.duztarih.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        e.vadta.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      DataCell(Text(
                                        "${e.geneltoplam}",
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
