import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Yenisatfatui extends StatefulWidget {
  @override
  _YenisatfatuiState createState() => _YenisatfatuiState();
}

class _YenisatfatuiState extends State<Yenisatfatui> {
  final _formKey = GlobalKey<FormState>();
  bool ischeck = false;
  List lis = [1];
  bool tahsett = true;
  bool tahsedilce = false;
  List<Kasa> ksl = [];
  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);
  List<Cari> liscar = [Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1)];
  List<Urun> lisurun;
  bool _isloading = false;
  TextEditingController conmus;
  TextEditingController conur;
  TextEditingController conur2;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String fatacik = "";
  String tahsacik = "";
  Urun urun = Urun(0, "", 1, "", 0, 0, 0, 0, 0);
  Urun urun2 = Urun(1, "", 1, "", 0, 0, 0, 0, 0);

  DateTime pickedDate;
  DateTime pickedduztar;
  @override
  void initState() {
    super.initState();
    conmus = TextEditingController();
    conur = TextEditingController();
    conur2 = TextEditingController();
    pickedDate = DateTime.now();
    pickedduztar = DateTime.now();
    APIServices.kasalistal().then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          kasalist = value;
          kas = kasalist[0];
          _isloading = false;
        });
      });
    });
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _pickDate1() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedduztar = date;
      });
  }

  cariara(String ar) async {
    liscar = await APIServices.cariara(ar);
  }

  urunara(String ar) async {
    lisurun = await APIServices.urunara(ar);
  }

  @override
  Widget _dropdownbutton(List<Kasa> userlist) {
    return Container(
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        //    borderRadius: BorderRadius.all(Radius.circular(15.0) //),
      ),
      child: DropdownButton<Kasa>(
        value: kas ?? Kasa(1, "", 1),
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        //  hint: Text("  $dropdownvalue"),
        // value: selectedUser[index],
        onChanged: (Kasa value) {
          kas = value;
          setState(() {});
        },
        items: userlist.map((Kasa user) {
          return DropdownMenuItem<Kasa>(
            value: user,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.kasaAd,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    conur.dispose();
    conur2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
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
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                "Satış Faturaları > Satış Faturası",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),

                              //   SizedBox(
                              //       width: 13,  ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Text(
                                  "Ahmet Seç",
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Fatura Açıklaması")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  onSaved: (v) {
                                                    fatacik = v;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Fatura Açıklaması boş olamaz";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Vazgeç'),
                                                    color: Colors.grey,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Kaydet'),
                                                    color: Colors.blueAccent,
                                                    textColor: Colors.white,
                                                    onPressed: () async {
                                                      num x = urun.adet *
                                                          (urun.verharsat +
                                                              urun.verharsat *
                                                                  urun.kdv);
                                                      num y = urun2.adet *
                                                          (urun2.verharsat +
                                                              urun2.verharsat *
                                                                  urun2.kdv);
                                                      Postfatura pf = Postfatura(
                                                          1,
                                                          fatacik,
                                                          cari.cariId,
                                                          pickedDate.toString(),
                                                          1,
                                                          urun.verharsat +
                                                              urun2.verharsat,
                                                          0,
                                                          urun.kdv + urun2.kdv,
                                                          x + y,
                                                          null,
                                                          kas.kasaid,
                                                          1,
                                                          null,
                                                          pickedDate.toString(),
                                                          tahsacik,
                                                          x + y,
                                                          x + y);
                                                      bool h = await APIServices
                                                          .faturaekle(pf);
                                                      print(h);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Müşteri")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 85,
                                                //   width: 45,
                                                child: TextFormField(
                                                  controller: conmus,
                                                  onChanged: (v) async {
                                                    setState(() {
                                                      _isloading = true;
                                                    });
                                                    await cariara(v);
                                                    setState(() {
                                                      _isloading = false;
                                                    });
                                                  },
                                                  decoration: const InputDecoration(
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
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true, //
                                          itemCount: liscar == null
                                              ? 0
                                              : liscar.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: ListTile(
                                                onTap: () {
                                                  cari = liscar[index];
                                                  conmus.text = cari.cariunvani;
                                                  liscar = [];
                                                  setState(() {});
                                                },
                                                title: Text(
                                                    liscar[index].cariunvani ??
                                                        ""),
                                              ),
                                            );
                                          }),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child:
                                                            Text("İrsaliye")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text(
                                                        "İrsaliyeli Satış"),
                                                    value: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //   height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text(
                                                        "Irsaliyesiz Satış"),
                                                    value: false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Tahsilat Durumu")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title:
                                                        Text("Tahsil Edilecek"),
                                                    value: tahsedilce,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                        tahsedilce = true;
                                                        tahsett = false;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //   height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title:
                                                        Text("Tahsil Edildi"),
                                                    value: tahsett,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                        tahsedilce = false;
                                                        tahsett = true;
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Tahsil edildiği tarih ve kasa hesabı"),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title: Text(
                                                          " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                      trailing: Icon(
                                                          Icons.calendar_today),
                                                      onTap: _pickDate,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: _dropdownbutton(kasalist)
                                                /* Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    '%18',
                                                    '%8',
                                                    '%1',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          "11", // selectedvalue
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                ),
                                              ),*/
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(Icons
                                                      .bar_chart_outlined)),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      "Tahsilat Açıklaması")),
                                            ],
                                          ))),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          height: 45,
                                          child: TextFormField(
                                            onSaved: (s) {
                                              tahsacik = s ?? "";
                                            },
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            validator: (value) {
                                              // validation logic
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(Icons
                                                      .bar_chart_outlined)),
                                              Expanded(
                                                  flex: 1,
                                                  child:
                                                      Text("Düzenleme Tarihi")),
                                            ],
                                          ))),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                    " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"),
                                                trailing:
                                                    Icon(Icons.calendar_today),
                                                onTap: _pickDate1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 40, color: Colors.grey[200]),
                                Container(
                                    width: wsize,
                                    child:
                                        DataTable(columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Ürün',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Miktar',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Birim',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Br. Fiyat',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Vergi',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Toplam',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ], rows: <DataRow>[
                                      DataRow(cells: [
                                        DataCell(TextField(
                                          controller: conur,
                                          onChanged: (v) async {
                                            setState(() {
                                              _isloading = true;
                                            });
                                            await urunara(v);
                                            setState(() {
                                              _isloading = false;
                                            });
                                          },
                                        )),
                                        DataCell(Text(
                                          "1",
                                        )),
                                        DataCell(Text(urun.birim)),
                                        DataCell(Text(
                                            urun.verharsat.toString() ?? "")),
                                        DataCell(Text(
                                          urun.kdv.toString() ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Text(
                                          urun == null
                                              ? ""
                                              : "${1 * (urun.verharsat + (urun.verharsat * urun.kdv))}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(TextField(
                                          controller: conur2,
                                          onChanged: (v) async {
                                            setState(() {
                                              _isloading = true;
                                            });
                                            await urunara(v);
                                            setState(() {
                                              _isloading = false;
                                            });
                                          },
                                        )),
                                        DataCell(Text(
                                          "1",
                                        )),
                                        DataCell(Text(urun2.birim)),
                                        DataCell(Text(
                                            urun2.verharsat.toString() ?? "")),
                                        DataCell(Text(
                                          urun2.kdv.toString() ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataCell(Text(
                                          urun == null
                                              ? ""
                                              : "${1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ])
                                    ])),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true, //
                                    itemCount:
                                        lisurun == null ? 0 : lisurun.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: ListTile(
                                          onTap: () {
                                            //urun1 i değiştiremiyorsun
                                            if (urun.barkodno == 0) {
                                              urun = lisurun[index];
                                              conur.text = urun.adi;
                                            } else {
                                              urun2 = lisurun[index];
                                              conur2.text = urun2.adi;
                                            }

                                            lisurun = [];
                                            setState(() {});
                                          },
                                          title: Text(lisurun[index].adi ?? ""),
                                        ),
                                      );
                                    }),
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
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8, 24.0, 0),
                                      child: Container(
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
                                                Text(
                                                    "${urun.verharsat + urun2.verharsat}")
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text("Toplam Kdv "),
                                                Spacer(),
                                                Text("${urun.kdv + urun2.kdv}")
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text("Genel Toplam"),
                                                Spacer(),
                                                Text(
                                                    "${(1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))) + 1 * (urun.verharsat + (urun.verharsat * urun.kdv))}")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
