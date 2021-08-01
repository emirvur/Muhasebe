import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofattahs.dart';

import 'package:Muhasebe/models/kasa.dart';

import 'package:Muhasebe/screen/satisfatayrinti.dart';
import 'package:Muhasebe/screen/yenisatfat.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/musteritahsekle.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/pdf.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Musteridetay extends StatefulWidget {
  final Dtocarilist dt;
  Musteridetay(this.dt);
  @override
  _MusteridetayState createState() => _MusteridetayState();
}

class _MusteridetayState extends State<Musteridetay> {
  final _formKey = GlobalKey<FormState>();
  List<Dtofattahs> lis = [];
  Cari cari;
  bool _isloading = true;
  bool tahsilform = false;
  bool acikfat = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  bool isexpa = false;
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
    Future.wait([
      APIServices.safcarial(widget.dt.cariId),
      APIServices.satcarifatal(widget.dt.cariId),
    ]).then((value) {
      setState(() {
        _isloading = false;
        cari = value[0];
        lis = value[1];
      });
    });
  }

  String fonk(Dtofattahs x) {
    print("111");
    DateTime far;
    if (x.vadta != "null") {
      print("yyy");
      //     print(dt.vadta);
      print("ooo");
      //       print(dt.vadta);
      int yil = int.tryParse(x.vadta.substring(0, 4));
      print(yil.toString());
      int ay = int.tryParse(x.vadta.substring(5, 7));
      print(ay.toString());
      int gun = int.tryParse(x.vadta.substring(8, 10));
      print(gun.toString());

      far = DateTime(yil, ay, gun);
      if (DateTime.now().difference(far).inDays.sign == 0) {
        return "Bugün";
      } else if (DateTime.now().difference(far).inDays.sign == -1) {
        return x.vadta;
      } else {
        return "${DateTime.now().difference(far).inDays.toString()} gün gecikti";
      }
    } else {
      far = DateTime(2000, 1, 1);
      return DateTime.now().difference(far).inDays.toString();
    }
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
            anchorpdf(pdf, "Ekstre");
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
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            /*  appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey.shade300,
                title: Wdgappbar("Müşteriler >", "Müşteri", "Ahmet Seç")),
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
              //   child: SingleChildScrollView(
              //   physics: ScrollPhysics(),
              // child: Column(
              //children: [
              child: Row(
                children: [
                  Container(
                      color: Colors.black87,
                      width: wsize.width / 5,
                      //    height: 500,
                      child: Wdgdrawer()),
                  Expanded(
                    flex: 78,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Wdgappbar("Müşteriler >", "Müşteri Detay", ""),
                          ),
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                          Chip(label: Text(widget.dt.katad)),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            height: 45,
                                            margin: EdgeInsets.all(20),
                                            child: FlatButton(
                                              child: Text(
                                                'Düzenle',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black),
                                              ),
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
                                          //  flex: 1,
                                          child: Row(
                                        children: [
                                          Icon(Icons.call),
                                          Text(cari == null ? "" : cari.telno),
                                        ],
                                      )),
                                      Expanded(
                                          //   flex: 1,
                                          child: Row(
                                        children: [
                                          Icon(Icons.mail),
                                          Text(cari == null ? "" : cari.eposta),
                                        ],
                                      )),
                                      Expanded(
                                          //   flex: 1,
                                          child: Row(
                                        children: [
                                          Icon(Icons.location_city),
                                          Text(cari == null ? "" : cari.adres),
                                        ],
                                      )),
                                      /*  Expanded(
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
                                                            child: Text(cari ==
                                                                    null
                                                                ? ""
                                                                : cari.adres)),
                                                        Divider(),
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                cari == null
                                                                    ? ""
                                                                    : cari.tckn)),
                                                      ],
                                                    ),
                                                    isExpanded: isexpa,
                                                  ),
                                                ],
                                              ),
                                            ),*/
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Icon(Icons.account_balance),
                                            Text(cari == null ? "" : cari.iban),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Icon(Icons.message),
                                            Text(cari == null ? "" : cari.faks),
                                          ],
                                        )),
                                    Expanded(flex: 1, child: Text("")),
                                  ]),
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
                                      width: wsize.width,
                                      child: DataTable(
                                          columns: <DataColumn>[
                                            /*       DataColumn(
                                              label: Checkbox(
                                                  value: false,
                                                  onChanged: (b) {}),
                                            ),*/
                                            DataColumn(
                                              label: Text(
                                                acikfat == false
                                                    ? 'Fatura Açıklaması'
                                                    : "Açık Faturalar",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .grey //fontStyle: FontStyle.italic
                                                    ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Düzenleme Tarihi',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .grey //fontStyle: FontStyle.italic
                                                    ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Vade Tarihi',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .grey //fontStyle: FontStyle.italic
                                                    ),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  'Kalan Meblağ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .teal //fontStyle: FontStyle.italic
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                          rows: lis
                                              .map((e) => DataRow(
                                                      color: MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  Colors.white),
                                                      cells: [
                                                        /*  DataCell(Checkbox(
                                                          value: true,
                                                          onChanged: (b) {},
                                                        )),*/
                                                        DataCell(InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        Satisfatayrinti(
                                                                            e)),
                                                              ).then((e) {
                                                                e != 1
                                                                    ? print(
                                                                        "gggg")
                                                                    : APIServices
                                                                            .satfatal()
                                                                        .then(
                                                                            (value) {
                                                                        Future.delayed(
                                                                            Duration(seconds: 1),
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            lis =
                                                                                value;

                                                                            //    _isloading = false;
                                                                          });
                                                                        });
                                                                      });

                                                                // setState(() {
                                                                //   lis.add(e);
                                                                //     print(lis.length.toString());
                                                                //     });
                                                                /*         setState(() {
                                          print("ee");
                                          _isloading = true;
                                        });
                                        setState(() async {
                                          await APIServices.urunal();
                                          _isloading = false;
                                        });*/
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    e.fataciklama
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      e.cariad,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              15)),
                                                                )
                                                              ],
                                                            ))),
                                                        DataCell(Text(
                                                            e.duztarih
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15))),
                                                        DataCell(Column(
                                                          children: [
                                                            Text(
                                                                e.vadta ==
                                                                        "null"
                                                                    ? e.alta
                                                                    : fonk(
                                                                        e), //e.vadta
                                                                //  .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        15)),
                                                            /*       e.vadta != null
                                                            ? Text(today
                                                                .difference(
                                                                    DateTime.parse(
                                                                        e.vadta))
                                                                .inDays
                                                                .toString())
                                                            : Text("")*/
                                                          ],
                                                        )),
                                                        DataCell(Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  e.geneltoplam - e.alinmism !=
                                                                          0
                                                                      ? "${e.geneltoplam - e.alinmism}"
                                                                      : "Tahsil edildi",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18)),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  "Genel Toplam ${e.geneltoplam}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15)),
                                                            ),
                                                          ],
                                                        )),
                                                      ]))
                                              .toList())),
                                  Divider(),
                                ],
                              ),
                              //     color: Colors.white,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 22,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Wdgappbarfake(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  Wdgappbarfake(),
                                  /*     Row(
                                    children: [
                                      Expanded(
                                          child: _dropdownbutton(kasalist)),
                                      /*     Expanded(
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
                                            ),*/
                                      Expanded(
                                        child: Container(
                                          //   height: 45,
                                          margin: EdgeInsets.all(5),
                                          child: FlatButton(
                                            child: Text('Tahsilat Ekle'),
                                            color: Colors.blue,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Mustahsekle(
                                                              widget.dt.cariId,
                                                              widget.dt
                                                                  .cariunvani)));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: wsize.width / 8,
                                      //   height: 45,
                                      margin: EdgeInsets.all(5),
                                      child: FlatButton(
                                        child: Text('Satış Fat. Oluştur'),
                                        color: Colors.grey,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Yenisatfat(
                                                      cari: widget.dt,
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: wsize.width / 8,
                                      //   height: 45,
                                      margin: EdgeInsets.all(5),
                                      child: FlatButton(
                                        child: Text('Tahsilat Ekle'),
                                        color: Colors.blue,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Mustahsekle(
                                                          widget.dt.cariId,
                                                          widget
                                                              .dt.cariunvani)));
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
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
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(widget.dt.bakiye.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Icon(FontAwesomeIcons.liraSign,
                                                size: 12),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  /*  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: wsize.width / 8,
                                      //   height: 45,
                                      margin: EdgeInsets.all(5),
                                      child: FlatButton(
                                        child: Text('Ekstre Gönder'),
                                        color: Colors.grey,
                                        textColor: Colors.white,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),*/
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: wsize.width / 8,
                                      //   height: 45,
                                      margin: EdgeInsets.all(5),
                                      child: FlatButton(
                                        child: Text('Ekstre Pdf indir'),
                                        color: Colors.blue,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          ekstrepdfmusteri(widget.dt.cariunvani,
                                                  lis, widget.dt.bakiye)
                                              .then((value) {
                                            print(value.toString());
                                            showAlertDialog(context, value);
                                          });
                                        },
                                      ),
                                    ),
                                  )

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
                          ),
                        ],
                      )),
                ],
              ),
              //      ],
              //      ),
              //      ),
            )));
  }
}
