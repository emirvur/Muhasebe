import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Satfatdetailicinurun extends StatefulWidget {
  final int dt;
  Satfatdetailicinurun(this.dt);
  @override
  _SatfatdetailicinurunState createState() => _SatfatdetailicinurunState();
}

class _SatfatdetailicinurunState extends State<Satfatdetailicinurun> {
  final _formKey = GlobalKey<FormState>();
  List<Dtourunhareket> lis = [];
  List<Dtotahsharfat> ltah = [];
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
  Dtofattahs fat =
      Dtofattahs(0, 0, 0, 0, "", "", "", "", 0, 0, 0, 0, "", "", 0, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController();
    APIServices.satfatdetayal(widget.dt).then((value) {
      print(widget.dt.toString());
      print(value.toString());
      fat = value;
      print(fat.fataciklama);
    });
    APIServices.fatuurundetay(widget.dt).then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
    APIServices.kasalistal().then((value) {
      kasalist = value;
      kas = kasalist[0];
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
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
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
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: LoadingOverlay(
        isLoading: _isloading,
        opacity: 0,
        progressIndicator: Wdgloadingalert(wsize: wsize),
        child: Row(
          children: [
            /*    Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),*/
            Expanded(
              flex: 78,
              child: Column(
                children: [
                  Wdgappbar("wwww", "gggg", "qqqsw"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.file_copy,
                                  color: Colors.red,
                                ),
                                Text(
                                  fat.fataciklama ?? "",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  height: 45,
                                  margin: EdgeInsets.all(20),
                                  child: FlatButton(
                                    child: Text('Düzenle'),
                                    color: Colors.white,
                                    textColor: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          /*      Container(
                                          child: Chip(
                                            label: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(widget.dt.katad)),
                                          ),
                                        ),*/
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Chip(
                                      label: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Center(
                                            child: Text(fat.katad ?? ""),
                                          )),
                                    ),
                                  )),
                              Expanded(flex: 3, child: Text("")),
                              Wdgfakebutton(),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: InkWell(
                                      onTap: () {
                                        //cariye git
                                      },
                                      child: Text(
                                        fat.cariad ?? "",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.calendar_today),
                                Text(
                                  fat.duztarih,
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              Row(
                                children: [
                                  Icon(Icons.format_list_numbered),
                                  Text(fat.cariId.toString() ?? ""),
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          Container(
                              width: wsize.width,
                              child: DataTable(
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.grey.shade200),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Ürün',
                                        style: TextStyle(
                                            //fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //    fontStyle:
                                            //   FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        ' Miktarı',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //      fontStyle:
                                            //        FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Br. Fiyat',
                                        style: TextStyle(
                                            //   fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //fontStyle:
                                            //      FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Vergi',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //    fontStyle:
                                            //      FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Toplam',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //       fontStyle:
                                            //         FontStyle.italic
                                            ),
                                      ),
                                    ),
                                  ],
                                  rows: lis
                                      .map((e) => DataRow(cells: [
                                            DataCell(Text(e.ad,
                                                style:
                                                    TextStyle(fontSize: 18))),
                                            DataCell(Text(
                                              e.miktar.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.brfiyat.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.vergi.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              "${e.brfiyat + (e.brfiyat * e.vergi) / 100}",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ]))
                                      .toList())),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: (2 * wsize.width) / 6,
                                height: 120,
                                color: Colors.white,
                              ),
                              Container(
                                width: (2 * wsize.width) / 6,
                                height: 120,
                                //     color: Colors.green,
                                child: Column(
                                  children: [
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          "Ara Toplam",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(fat.aratop.toString() ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Toplam Kdv ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Text(fat.kdv.toString() ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Genel Toplam",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Text(fat.geneltoplam.toString() ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      //     color: Colors.white,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Kalan    ${fat.geneltoplam - fat.alinmism}TL",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ltah.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 24.0),
                                      child: Text(ltah[index].tediltar,
                                          style: TextStyle(
                                            //   fontSize: 18,
                                            color: Colors.grey,
                                            //       fontWeight:
                                            //             FontWeight.bold
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(children: [
                                      Icon(Icons.monetization_on),
                                      Text(ltah[index].ad,
                                          style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            //       fontWeight:
                                            //         FontWeight.bold
                                          )),
                                    ]),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Müşteriden Tahsilat   ${ltah[index].alinmismik} TL",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                              Divider(color: Colors.grey)
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 22,
                child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wdgappbarfake(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            //   height: 45,
                            margin: EdgeInsets.all(5),
                            child: FlatButton(
                              child: Row(
                                children: [
                                  Icon(Icons.mail),
                                  Text('Paylaş'),
                                ],
                              ),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                /*    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PDFExcel(widget.dt, lis)));*/
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            //    height: 45,
                            margin: EdgeInsets.all(5),
                            child: FlatButton(
                              child: Row(
                                children: [
                                  Icon(Icons.print),
                                  Text('Yazdır'),
                                ],
                              ),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                /*     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PDFSave(widget.dt, lis)));*/
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: wsize.width / 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (fat.geneltoplam - fat.alinmism) == 0
                                  ? Icon(Icons.verified,
                                      color: Colors.greenAccent)
                                  : Text(""),
                              (fat.geneltoplam - fat.alinmism == 0)
                                  ? Container(
                                      height: 40,
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Tahsil Edildi ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 18),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: "${fat.alinmism} ",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18)
                                                  //       fontWeight:
                                                  //              FontWeight.w300)
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 40,
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Kalan ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      " ${fat.geneltoplam - fat.alinmism}",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18)
                                                  //       fontWeight:
                                                  //              FontWeight.w300)
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      //     width: 16.0,
                                      color: Colors.grey),
                                  bottom: BorderSide(
                                      //   width: 16.0,
                                      color: Colors.grey),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.access_alarm),
                                  Text(
                                    "Tahsilat Talep et",
                                    style: TextStyle(
                                      decoration: fat.durum == 1
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  Icon(Icons.mail)
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /*    FlatButton(
                                            child: Text('Vazgeç'),
                                            color: Colors.blueAccent,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              setState(() {
                                                print("nn");
                                                tahsilform = false;
                                              });
                                            },
                                          ),*/
                              tahsilform != true
                                  ? Container(
                                      width: wsize.width / 5,
                                      child: FlatButton(
                                        child: Text('Tahsilat Ekle'),
                                        color: fat.durum == 0
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          fat.durum == 1
                                              ? {}
                                              : setState(() {
                                                  print("nn");
                                                  contar.text =
                                                      selectedDate.toString();
                                                  tahsilform = true;
                                                });
                                        },
                                      ),
                                    )
                                  : Text(""),
                            ],
                          ),
                          tahsilform == false
                              ? Text("")
                              : Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          "Tahsilat Ekle",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                    onTap: () async {
                                                      await _selectDate(
                                                          context);
                                                    },
                                                    child: Text("Tarih*"))),
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
                                                            " ${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}"),
                                                        trailing: Icon(Icons
                                                            .calendar_today),
                                                        onTap: () async {
                                                          await _selectDate(
                                                              context);
                                                        }),
                                                  ],
                                                ),
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
                                                flex: 1, child: Text("Hesap*")),
                                            Expanded(
                                                flex: 4,
                                                child: _dropdownbutton(kasalist)
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
                                        padding: const EdgeInsets.all(8.0),
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
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    print("uu");
                                                    var x = num.tryParse(value);
                                                    if (x == null) {
                                                      return "Lütfen geçerli bir sayı giriniz";
                                                    }
                                                    if (x >
                                                        (fat.geneltoplam -
                                                            fat.alinmism)) {
                                                      return "Kalan miktardan daha büyük bir sayı giremezsiniz";
                                                    }
                                                    return null;

                                                    // validation logic
                                                  },
                                                  onSaved: (v) {
                                                    var x = num.tryParse(v);

                                                    deger = x;
                                                  },
                                                ),
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
                                                child: Text("Açıklama*")),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  controller: conacik,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Açıklama kısmı boş olamaz";
                                                    }
                                                    return null;
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
                                      Row(
                                        children: [
                                          FlatButton(
                                            child: Text('Vazgeç'),
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {
                                              setState(() {
                                                print("nn");
                                                tahsilform = false;
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Tahsilat Ekle'),
                                            color: Colors.white,
                                            textColor: Colors.blue,
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                print("ggg");
                                                _formKey.currentState.save();

                                                Tahsput tp = Tahsput(
                                                    fat.tahsid,
                                                    deger,
                                                    fat.geneltoplam,
                                                    selectedDate.toString(),
                                                    kas.kasaid,
                                                    conacik.text);
                                                bool b = await APIServices
                                                    .tahsharguncelle(tp);
                                                print(b.toString());
                                                Navigator.of(context).pop(1);
                                              } else {
                                                print("hfgf");
                                              }
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
/*
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
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                title: Wdgappbar(
                    "Satış Faturaları >", "Satış Faturası", "Ahmet Seç")),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors
                    .black87, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(child: Wdgdrawer()),
            ),
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
              child: Column(
                children: [
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
                                                  Text(fat.geneltoplam
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
                                                        child:
                                                            Text("Açıklama*")),
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
              ),
            )));
  }
}
*/

/*

import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
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
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                title: Wdgappbar(
                    "Satış Faturaları >", "Satış Faturası", "Ahmet Seç")),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors
                    .black87, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(child: Wdgdrawer()),
            ),
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
              child: Column(
                children: [
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
                                                  Text(fat.geneltoplam
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
                                                        child:
                                                            Text("Açıklama*")),
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
              ),
            )));
  }
}



*/
