import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SatisfatDetailicinurun extends StatefulWidget {
  final int dt;
  SatisfatDetailicinurun(this.dt);
  @override
  _SatisfatDetailicinurunState createState() => _SatisfatDetailicinurunState();
}

class _SatisfatDetailicinurunState extends State<SatisfatDetailicinurun> {
  final _formKey = GlobalKey<FormState>();
  List<Dtourunhareket> lis = [];
  bool _isloading = true;
  bool tahsilform = false;
  Dtofattahs fat;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contar = TextEditingController();
    APIServices.satfatdetayal(widget.dt).then((value) {
      print(widget.dt.toString());
      print(value.toString());
      fat = value;
      print(fat.katad);
    });
    APIServices.fatuurundetay(widget.dt).then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        contar.text =
            selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LoadingOverlay(
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
                        Text(
                          "Satış Faturaları > Satış Faturaları",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),

                        //   SizedBox(
                        //       width: 13,  ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Text(
                            "Ahmet Seç",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.text_format),
                                      Text("Satış Faturası"),
                                      Spacer(),
                                      Container(
                                        height: 45,
                                        margin: EdgeInsets.all(20),
                                        child: FlatButton(
                                          child: Text('Düzenle'),
                                          color: Colors.grey,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Container(
                                    child: Chip(
                                      label: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(fat.katad)),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(fat.cariad),
                                      Row(children: [
                                        Icon(Icons.calendar_today)
                                      ]),
                                      Text("ff")
                                    ],
                                  ),
                                  Divider(),
                                  Container(
                                      width: wsize,
                                      child: DataTable(
                                          columns: const <DataColumn>[
                                            DataColumn(
                                              label: Text(
                                                'Ürün',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                ' Miktarı',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Br. Fiyat',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Vergi',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Toplam',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                          ],
                                          rows: lis
                                              .map((e) => DataRow(cells: [
                                                    DataCell(Text(e.ad)),
                                                    DataCell(Text(
                                                      e.miktar.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    DataCell(Text(
                                                      e.brfiyat.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    DataCell(Text(
                                                      e.vergi.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    DataCell(Text("---")),
                                                  ]))
                                              .toList())),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: (2 * wsize) / 6,
                                        height: 120,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: (2 * wsize) / 6,
                                        height: 120,
                                        //     color: Colors.green,
                                        child: Column(
                                          children: [
                                            Divider(),
                                            Row(
                                              children: [
                                                Text("Ara Toplam"),
                                                Spacer(),
                                                Text(fat.aratop.toString())
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text("Toplam Kdv "),
                                                Spacer(),
                                                Text(fat.kdv.toString())
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text("Genel Toplam"),
                                                Spacer(),
                                                Text(fat.geneltoplam.toString())
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(fat.duztarih.toString()),
                              Row(children: [
                                Icon(Icons.calendar_today),
                                Text("Kasa Hesabı")
                              ]),
                              Text("Müşteriden Tahsilat   ${fat.alinmism} TL")
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                "Kalan    ${fat.geneltoplam - fat.alinmism}TL"),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  //   height: 45,
                                  margin: EdgeInsets.all(5),
                                  child: FlatButton(
                                    child: Text('Sil'),
                                    color: Colors.grey,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  //    height: 45,
                                  margin: EdgeInsets.all(5),
                                  child: FlatButton(
                                    child: Text('Düzenle'),
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: wsize / 5,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                //     borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.enhanced_encryption),
                                      Text(
                                          "Tahsil Edildi   ${fat.alinmism} TL"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FlatButton(
                                        child: Text('Vazgeç'),
                                        color: Colors.blueAccent,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            print("nn");
                                            tahsilform = false;
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Tahsilat Ekle'),
                                        color: Colors.blueAccent,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            print("nn");
                                            contar.text =
                                                selectedDate.toString();
                                            tahsilform = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  tahsilform == false
                                      ? Text("")
                                      : Column(
                                          children: [
                                            Center(
                                              child: Text("Tahsilat Ekle"),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                          onTap: () async {
                                                            await _selectDate(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Tarih*"))),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      height: 45,
                                                      child: TextFormField(
                                                        controller: contar,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          // validation logic
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text("Hesap*")),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      height: 45,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          // validation logic
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text("Meblağ*")),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      height: 45,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          // validation logic
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text("Açıklama*")),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      height: 45,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          // validation logic
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: wsize / 5,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                //     borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Fatura Geçmişi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.keyboard_arrow_down),
                                    title: Text("Fatura Güncellendi"),
                                    subtitle: Text("03 Şubat 2020"),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.keyboard_arrow_down),
                                    title: Text("Fatura Güncellendi"),
                                    subtitle: Text("03 Şubat 2020"),
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.keyboard_arrow_down),
                                    title: Text("Fatura Güncellendi"),
                                    subtitle: Text("03 Şubat 2020"),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            )));
  }
}
