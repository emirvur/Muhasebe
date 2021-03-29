import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtoodeharfat.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/odeput.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AlisfatDetailui extends StatefulWidget {
  final Dtofatode dt;
  AlisfatDetailui(this.dt);
  @override
  _AlisfatDetailuiState createState() => _AlisfatDetailuiState();
}

class _AlisfatDetailuiState extends State<AlisfatDetailui> {
  final _formKey = GlobalKey<FormState>();
  List<Dtourunhareket> lis = [];
  List<Dtoodeharfat> ltah = [];
  bool _isloading = true;
  bool tahsilform = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String acikla = "";
  num deger;
  TextEditingController conacik;
  TextEditingController condeg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController();
    APIServices.odeharfaticin(widget.dt.odeid).then((value) {
      print("test1");
      print(value);
      ltah = value;
    });
    APIServices.kasalistal().then((value) {
      kasalist = value;
      kas = kasalist[0];
    });
    APIServices.fatuurundetay(widget.dt.fatid).then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
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
    conacik.dispose();
    condeg.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(ltah.length.toString());
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
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
                            "Giderler > Fiş/Faturaları",
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
                                        Text(widget.dt.fataciklama),
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
                                            child: Text(widget.dt.katad)),
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.dt.cariad),
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
                                                  ' Miktar',
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
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                      DataCell(Text(
                                                        e.brfiyat.toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                      DataCell(Text(
                                                        e.vergi.toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                  Text(widget.dt.aratop
                                                      .toString())
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Text("Toplam Kdv "),
                                                  Spacer(),
                                                  Text(widget.dt.kdv.toString())
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Text("Genel Toplam"),
                                                  Spacer(),
                                                  Text(widget.dt.geneltoplam
                                                      .toString())
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
                            /*   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.dt.duztarih.toString()),
                                Row(children: [
                                  Icon(Icons.calendar_today),
                                  Text("Kasa Hesabı")
                                ]),
                                Text(
                                    "Müşteriden Tahsilat   ${widget.dt.alinmism} TL")
                              ],
                            ),*/
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ltah.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ltah[index].odenmistar),
                                    Row(children: [
                                      Icon(Icons.calendar_today),
                                      Text(ltah[index].ad),
                                    ]),
                                    Text(
                                        "Fiş/Fatura Ödeme   ${ltah[index].odendimik} TL")
                                  ],
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "Kalan    ${widget.dt.geneltoplam - widget.dt.odendimik}TL"),
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
                                            "Ödenen Miktar  ${widget.dt.odendimik} TL"),
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
                                          child: Text('Ödeme Ekle'),
                                          color: widget.dt.durum == 0
                                              ? Colors.blueAccent
                                              : Colors.grey,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            widget.dt.durum == 1
                                                ? {}
                                                : setState(() {
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
                                                child: Text("Ödeme Ekle"),
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
                                                            child: Text(
                                                                "Tarih*"))),
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
                                                        child: _dropdownbutton(
                                                            kasalist)
                                                        /* Container(
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
                                                      ),*/
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
                                                          controller: condeg,
                                                          //         initialValue:
                                                          //               " ${widget.dt.geneltoplam - widget.dt.alinmism}",
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder()),
                                                          validator: (value) {
                                                            var x =
                                                                num.tryParse(
                                                                    value);
                                                            if (x == null) {
                                                              return "Lütfen geçerli bir sayı giriniz";
                                                            }
                                                            return null;

                                                            // validation logic
                                                          },
                                                          onSaved: (v) {
                                                            var x =
                                                                num.tryParse(v);

                                                            deger = x;
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
                                                        child:
                                                            Text("Açıklama*")),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        height: 45,
                                                        child: TextFormField(
                                                          controller: conacik,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder()),
                                                          validator: (value) {
                                                            // validation logic
                                                          },
                                                          onSaved: (v) {
                                                            acikla = v;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    /*       if (_formKey.currentState
                                                        .validate()) {
                                                      _formKey.currentState
                                                          .save();
                                                    }*/
                                                    //         _formKey.currentState
                                                    //               .save();
                                                    num x = num.tryParse(
                                                        condeg.text);
                                                    Odeput tp = Odeput(
                                                        widget.dt.odeid,
                                                        x,
                                                        widget.dt.geneltoplam,
                                                        selectedDate.toString(),
                                                        kas.kasaid,
                                                        conacik.text);
                                                    bool b = await APIServices
                                                        .odeharguncelle(tp);
                                                    print(b.toString());
                                                  },
                                                  child:
                                                      Text("Odeme Ekle Ekle"))
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
              ),
            )));
  }
}
