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
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/pdf.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
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
    condeg = TextEditingController(
        text: (widget.dt.geneltoplam - widget.dt.odendimik).toString());
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
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

  showAlertDialog(BuildContext context, dynamic pdf) {
    AlertDialog alert = AlertDialog(
      // title: Text("Simple Alert"),
      content: Text("Pdf dosyası indirme"),
      actions: [
        FlatButton(
          child: Text("İptal"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("İndir"),
          onPressed: () {
            anchorpdf(pdf, "alisfat");
            Navigator.of(context).pop();
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
        //  contar.text =
        //    selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
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
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      /* appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          title: Wdgappbar("Giderler >", "Fiş/Fatura", "Ahmet Seç")),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.black87, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(child: Wdgdrawer()),
      ),*/
      backgroundColor: Colors.grey.shade300,
      body: LoadingOverlay(
        isLoading: _isloading,
        opacity: 0.2,
        progressIndicator: Wdgloadingalert(wsize: wsize),
        child: Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),
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
                                  widget.dt.fataciklama,
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
                                            child: Text(widget.dt.katad),
                                          )),
                                    ),
                                  )),
                              Expanded(flex: 3, child: Text("")),
                              Wdgfakebutton()
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
                                    child: Text(
                                      widget.dt.cariad,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.calendar_today),
                                Text(
                                  widget.dt.duztarih,
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              Row(
                                children: [
                                  Icon(Icons.format_list_numbered),
                                  Text(widget.dt.cariId.toString()),
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
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Ürün',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        ' Miktar',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Br. Fiyat',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Vergi',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Toplam',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  rows: lis
                                      .map((e) => DataRow(cells: [
                                            DataCell(Text(
                                              e.ad,
                                              style: TextStyle(fontSize: 18),
                                            )),
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
                                        Text(widget.dt.aratop.toString())
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          "Toplam Kdv ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(
                                          widget.dt.kdv.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          "Genel Toplam",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(
                                          widget.dt.geneltoplam.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      //   color: Colors.white,
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
                    child: Text(
                        "Kalan    ${widget.dt.geneltoplam - widget.dt.odendimik}TL",
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
                                      child: Text(ltah[index].odenmistar,
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
                                          "Fiş/Fatura Ödeme  ${ltah[index].odendimik} TL",
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
                  children: [
                    Wdgappbarfake(),
                    tahsilform == false
                        ? Row(
                            children: [
                              Container(
                                //   height: 45,
                                margin: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Text('Diğer'),
                                  color: Colors.white,
                                  textColor: Colors.grey,
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                //    height: 45,
                                margin: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Text('Ödeme Ekle'),
                                  color: widget.dt.durum == 1
                                      ? Colors.grey.shade200
                                      : Colors.brown,
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
                              ),
                            ],
                          )
                        : Text(""),
                    Container(
                      width: wsize.width / 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        //     borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                widget.dt.durum == 1
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Ödendi ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            "${widget.dt.geneltoplam} TL",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Kalan ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Text(
                                                "${widget.dt.geneltoplam - widget.dt.odendimik} TL",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          tahsilform == false
                              ? Column(
                                  children: [
                                    Center(
                                      child: FlatButton(
                                        child: Text('Paylaş'),
                                        color: Colors.blueAccent,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            print("nn");
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: FlatButton(
                                        child: Text('Yazdır'),
                                        color: Colors.blueAccent,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            _isloading = true;
                                          });
                                          createPDF1(
                                                  widget.dt.cariad,
                                                  widget.dt.duztarih,
                                                  widget.dt,
                                                  lis)
                                              .then((value) {
                                            setState(() {
                                              _isloading = false;
                                            });
                                            showAlertDialog(context, value);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Text(""),
                          tahsilform == false
                              ? Text("")
                              : Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text("Ödeme Ekle",
                                            style: TextStyle(fontSize: 18)),
                                      ),
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
                                                    var x = num.tryParse(value);
                                                    if (x == null) {
                                                      return "Lütfen geçerli bir sayı giriniz";
                                                    }
                                                    if (x >
                                                        widget.dt.geneltoplam -
                                                            widget
                                                                .dt.odendimik) {
                                                      return "Kalandan daha büyük sayı giremezsiniz";
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
                                                  //        validator: (value) {
                                                  // validation logic
                                                  //          },
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
                                          TextButton(
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();

                                                  num x =
                                                      num.tryParse(condeg.text);
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
                                                  Navigator.of(context).pop(1);
                                                }
                                              },
                                              child: Text("Odeme Ekle")),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                    /*      SizedBox(
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
                )),
          ],
        ),
      ),
    ));
  }
}

/*

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
    condeg = TextEditingController(
        text: (widget.dt.geneltoplam - widget.dt.odendimik).toString());
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
        //  contar.text =
        //    selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
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
            backgroundColor: Colors.grey.shade300,
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          RichText(
                            text: TextSpan(
                              text: "Giderler >",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 24),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Fiş / Fatura",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 24)
                                    //       fontWeight:
                                    //              FontWeight.w300)
                                    ),
                              ],
                            ),
                          ),
                          //   SizedBox(
                          //       width: 13,  ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Text(
                              "Ahmet Seç",
                              style: TextStyle(
                                fontSize: 24.0, // fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 24.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.file_copy,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            widget.dt.fataciklama,
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          Spacer(),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
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
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: Chip(
                                                label: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Center(
                                                      child:
                                                          Text(widget.dt.katad),
                                                    )),
                                              ),
                                            )),
                                        Expanded(flex: 3, child: Text("")),
                                        Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              margin: EdgeInsets.all(20),
                                              child: FlatButton(
                                                child: Text(''),
                                                color: Colors.white,
                                                textColor: Colors.white,
                                                onPressed: () {},
                                              ),
                                            ),
                                            Container(
                                              height: 5,
                                              margin: EdgeInsets.all(20),
                                              child: FlatButton(
                                                child: Text(''),
                                                color: Colors.white,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  //kaydet işlemi yapp
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0),
                                              child: Text(
                                                widget.dt.cariad,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(children: [
                                          Icon(Icons.calendar_today),
                                          Text(widget.dt.duztarih)
                                        ]),
                                        Row(
                                          children: [
                                            Icon(Icons.format_list_numbered),
                                            Text(widget.dt.cariId.toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    Container(
                                        width: wsize,
                                        child: DataTable(
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.grey.shade200),
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                label: Text(
                                                  'Ürün',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  ' Miktar',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Br. Fiyat',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Vergi',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Toplam',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                            rows: lis
                                                .map((e) => DataRow(cells: [
                                                      DataCell(Text(e.ad)),
                                                      DataCell(Text(
                                                        e.miktar.toString(),
                                                      )),
                                                      DataCell(Text(
                                                        e.brfiyat.toString(),
                                                      )),
                                                      DataCell(Text(
                                                        e.vergi.toString(),
                                                      )),
                                                      DataCell(Text(
                                                          "${e.brfiyat + (e.brfiyat * e.vergi) / 100}")),
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
                                                  Text(
                                                    "Ara Toplam",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Text(widget.dt.aratop
                                                      .toString())
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Toplam Kdv ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    widget.dt.kdv.toString(),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Genel Toplam",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    widget.dt.geneltoplam
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                //   color: Colors.white,
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
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24.0),
                                        child: Text(ltah[index].odenmistar,
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
                                            "Fiş/Fatura Ödeme  ${ltah[index].odendimik} TL",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "Kalan    ${widget.dt.geneltoplam - widget.dt.odendimik}TL",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 22,
                          child: Column(
                            children: [
                              tahsilform == false
                                  ? Row(
                                      children: [
                                        Container(
                                          //   height: 45,
                                          margin: EdgeInsets.all(5),
                                          child: FlatButton(
                                            child: Text('Diğer'),
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                        Container(
                                          //    height: 45,
                                          margin: EdgeInsets.all(5),
                                          child: FlatButton(
                                            child: Text('Ödeme Ekle'),
                                            color: widget.dt.durum == 1
                                                ? Colors.grey.shade100
                                                : Colors.brown,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              widget.dt.durum == 1
                                                  ? {}
                                                  : setState(() {
                                                      print("nn");
                                                      contar.text = selectedDate
                                                          .toString();
                                                      tahsilform = true;
                                                    });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(""),
                              Container(
                                width: wsize / 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  //     borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          widget.dt.durum == 1
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Ödendi ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      "${widget.dt.geneltoplam} TL",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text("Kalan ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18)),
                                                      Text(
                                                          "${widget.dt.geneltoplam - widget.dt.odendimik} TL",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18)),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    tahsilform == false
                                        ? Center(
                                            child: FlatButton(
                                              child: Text('Paylaş'),
                                              color: Colors.blueAccent,
                                              textColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  print("nn");
                                                });
                                              },
                                            ),
                                          )
                                        : Text(""),
                                    tahsilform == false
                                        ? Text("")
                                        : Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text("Ödeme Ekle",
                                                      style: TextStyle(
                                                          fontSize: 18)),
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
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              ListTile(
                                                                  title: Text(
                                                                      " ${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      () async {
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child:
                                                              Text("Hesap*")),
                                                      Expanded(
                                                          flex: 4,
                                                          child:
                                                              _dropdownbutton(
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
                                                          child:
                                                              Text("Meblağ*")),
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
                                                              if (x >
                                                                  widget.dt
                                                                          .geneltoplam -
                                                                      widget.dt
                                                                          .odendimik) {
                                                                return "Kalandan daha büyük sayı giremezsiniz";
                                                              }
                                                              return null;

                                                              // validation logic
                                                            },
                                                            onSaved: (v) {
                                                              var x =
                                                                  num.tryParse(
                                                                      v);

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
                                                          child: Text(
                                                              "Açıklama*")),
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
                                                            //        validator: (value) {
                                                            // validation logic
                                                            //          },
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
                                                    TextButton(
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            _formKey
                                                                .currentState
                                                                .save();

                                                            num x =
                                                                num.tryParse(
                                                                    condeg
                                                                        .text);
                                                            Odeput tp = Odeput(
                                                                widget.dt.odeid,
                                                                x,
                                                                widget.dt
                                                                    .geneltoplam,
                                                                selectedDate
                                                                    .toString(),
                                                                kas.kasaid,
                                                                conacik.text);
                                                            bool b =
                                                                await APIServices
                                                                    .odeharguncelle(
                                                                        tp);
                                                            print(b.toString());
                                                            Navigator.of(
                                                                    context)
                                                                .pop(1);
                                                          }
                                                        },
                                                        child:
                                                            Text("Odeme Ekle")),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              /*      SizedBox(
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
                          )),
                    ],
                  ),
                ],
              ),
            )));
  }
}



*/
