import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtokasahars.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Tedardetay extends StatefulWidget {
  final Dtocarilist dt;
  Tedardetay(this.dt);
  @override
  _TedardetayState createState() => _TedardetayState();
}

class _TedardetayState extends State<Tedardetay> {
  final _formKey = GlobalKey<FormState>();
  List<Dtokasahar> lis = [];
  Cari cari;
  bool _isloading = true;
  bool tahsilform = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  List<String> kasalist = [
    "",
    "Satış Faturası oluştur",
    "Alış faturası oluştur"
  ];
  Kasa kas = Kasa(1, "", 1);
  String acikla = "";
  num deger;
  String v;
  TextEditingController conacik;
  TextEditingController condeg;
  bool isexpa = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController();

    /*APIServices.kasalistal().then((value) {
      kasalist = value;
      kas = kasalist[0];
    });*/
    APIServices.safcarial(widget.dt.cariId).then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          cari = value;
          _isloading = false;
        });
      });
    });
  }

  @override
  Widget _dropdownbutton(List<String> userlist) {
    return Container(
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        //    borderRadius: BorderRadius.all(Radius.circular(15.0) //),
      ),
      child: DropdownButton<String>(
        value: kasalist[0],
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        //  hint: Text("  $dropdownvalue"),
        // value: selectedUser[index],
        onChanged: (String value) {
          v = value;
          setState(() {});
        },
        items: userlist.map((String user) {
          return DropdownMenuItem<String>(
            value: user,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  user,
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
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                title: Wdgappbar("Tedarikçiler >", "Tedarikçi", "Ahmet Seç")),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors
                    .black87, //This will change the drawer background to blue.
                //other styles
              ),
              child: Drawer(child: Wdgdrawer()),
            ),
            backgroundColor: Colors.grey.shade300,
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 78,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          //     Icon(Icons.),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              widget.dt.cariunvani,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              Chip(
                                                  label: Text(widget.dt.katad)),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all()),
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
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Icon(Icons.call),
                                              Text(cari.telno),
                                            ],
                                          )),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Icon(Icons.mail),
                                              Text(cari.eposta),
                                            ],
                                          )),
                                          Expanded(
                                            child: ExpansionPanelList(
                                              expansionCallback:
                                                  (int index, bool isExpanded) {
                                                setState(() {
                                                  isexpa = !isexpa;
                                                });
                                              },
                                              children: [
                                                ExpansionPanel(
                                                  headerBuilder:
                                                      (BuildContext context,
                                                          bool isExpanded) {
                                                    return ListTile(
                                                      title: Text(
                                                          'Tüm bilgileri göster'),
                                                    );
                                                  },
                                                  body: Column(
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child:
                                                              Text(cari.adres)),
                                                      Divider(),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child:
                                                              Text(cari.tckn)),
                                                    ],
                                                  ),
                                                  isExpanded: isexpa,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      /*    Row(
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
                                      Divider(),*/
                                      Container(
                                          width: wsize,
                                          child: DataTable(
                                              headingRowColor:
                                                  MaterialStateColor
                                                      .resolveWith((states) =>
                                                          Colors.grey.shade200),
                                              columns: const <DataColumn>[
                                                DataColumn(
                                                  label: Text(
                                                    'İşlem Türü',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'İşlem  Tarihi',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'İlgili Hesap',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Açıklama',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Meblağ',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    'Bakiye',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                              rows: lis
                                                  .map((e) => DataRow(cells: [
                                                        DataCell(Text(e.durum
                                                            .toString())),
                                                        DataCell(Text(
                                                          e.durum == 0
                                                              ? e.tediltar
                                                                  .toString()
                                                              : e.durum == 1
                                                                  ? e.odenmistar
                                                                  : "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        DataCell(Text(
                                                          "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        DataCell(Text(
                                                          e.durum == 0
                                                              ? e.tahsaciklama
                                                                  .toString()
                                                              : e.durum == 1
                                                                  ? e.odaciklama
                                                                  : e.miktaraciklamasi,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                        DataCell(
                                                          Text(e.durum == 0
                                                              ? e.alinmismik
                                                                  .toString()
                                                              : e.durum == 1
                                                                  ? e.odendimik
                                                                  : e.miktar
                                                                      .toString()),
                                                        ),
                                                        DataCell(Text(e
                                                            .netbakiye
                                                            .toString())),
                                                      ]))
                                                  .toList())),
                                      Divider(),
                                    ],
                                  ),
                                  //     color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 22,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: _dropdownbutton(kasalist)),
                                        Expanded(
                                          child: Container(
                                            //   height: 45,
                                            margin: EdgeInsets.all(5),
                                            child: FlatButton(
                                              child: Text('Ödeme'),
                                              color: Colors.grey.shade500,
                                              textColor: Colors.brown,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            //   height: 45,
                                            margin: EdgeInsets.all(5),
                                            child: FlatButton(
                                              child: Text('Tahsilat Ekle'),
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bakiye",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(widget.dt.bakiye.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        //   height: 45,
                                        margin: EdgeInsets.all(5),
                                        child: FlatButton(
                                          child: Text('Ekstre Gönder'),
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),

                                    /*  Container(
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
                                                  "Tahsil Edildi   ${widget.dt.alinmism} TL"),
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
                                                          Tahsput tp = Tahsput(
                                                              widget.dt.tahsid,
                                                              x,
                                                              widget.dt.geneltoplam,
                                                              selectedDate.toString(),
                                                              kas.kasaid,
                                                              conacik.text);
                                                          bool b = await APIServices
                                                              .tahsharguncelle(tp);
                                                          print(b.toString());
                                                        },
                                                        child: Text("Tahsilat Ekle"))
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),*/
                                    /*    SizedBox(
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
                                    )*/
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
