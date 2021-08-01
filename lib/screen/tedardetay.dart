import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtokasahars.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/screen/alisfatayrinti.dart';
import 'package:Muhasebe/screen/yenialisfat.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/tedarodeekle.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/pdf.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Tedardetay extends StatefulWidget {
  final Dtocarilist dt;
  Tedardetay(this.dt);
  @override
  _TedardetayState createState() => _TedardetayState();
}

class _TedardetayState extends State<Tedardetay> {
  final _formKey = GlobalKey<FormState>();
  List<Dtofatode> lis = [];
  Cari cari;
  bool _isloading = true;
  bool tahsilform = false;
  bool acikfat = false;
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

    Future.wait([
      APIServices.safcarial(widget.dt.cariId),
      APIServices.odecarifatal(widget.dt.cariId),
    ]).then((value) {
      setState(() {
        _isloading = false;
        cari = value[0];
        lis = value[1];
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

  String fonk1(Dtofatode x) {
    print("111");
    DateTime far;
    if (x.odenecektar != "null") {
      print("yyy");
      //     print(dt.vadta);
      print("ooo");
      //       print(dt.vadta);
      int yil = int.tryParse(x.odenecektar.substring(0, 4));
      print(yil.toString());
      int ay = int.tryParse(x.odenecektar.substring(5, 7));
      print(ay.toString());
      int gun = int.tryParse(x.odenecektar.substring(8, 10));
      print(gun.toString());

      far = DateTime(yil, ay, gun);
      if (DateTime.now().difference(far).inDays.sign == 0) {
        return "Bugün";
      } else if (DateTime.now().difference(far).inDays.sign == -1) {
        return x.odenecektar;
      } else {
        return "${DateTime.now().difference(far).inDays.toString()} gün gecikti";
      }
    } else {
      far = DateTime(2000, 1, 1);
      return DateTime.now().difference(far).inDays.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      /*   appBar: AppBar(
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
            ),*/
      backgroundColor: Colors.grey.shade300,
      body: //SingleChildScrollView(
          // physics: ScrollPhysics(),
          //   child:
          LoadingOverlay(
        isLoading: _isloading,
        opacity: 0,
        progressIndicator: Wdgloadingalert(wsize: wsize),
        child: // Column(
            //  children: [
            Row(
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
                      child: Wdgappbar("Tedarikçiler>", "Tedarikçi Detay", ""),
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
                                  padding: const EdgeInsets.only(left: 8.0),
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
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 45,
                                      margin: EdgeInsets.all(20),
                                      child: FlatButton(
                                        child: Text(
                                          'Düzenle',
                                          style: TextStyle(
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.lineThrough),
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
                                    child: Row(
                                  children: [
                                    Icon(Icons.call),
                                    Text(cari == null ? "" : cari.telno),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Icon(Icons.mail),
                                    Text(cari == null ? "" : cari.eposta),
                                  ],
                                )),
                                Expanded(
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
                                      /*    DataColumn(
                                        label: Checkbox(
                                            value: false, onChanged: (b) {}),
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
                                          'Ödenecek Tarih',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors
                                                  .grey //fontStyle: FontStyle.italic
                                              ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: //Align(
                                            //    alignment: Alignment.centerRight,
                                            //child:
                                            Expanded(
                                          child: Text(
                                            'Kalan Meblağ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .teal //fontStyle: FontStyle.italic
                                                ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        //    ),
                                      ),
                                    ],
                                    rows: lis
                                        .map((e) => DataRow(
                                                color: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.white),
                                                cells: [
                                                  /*       DataCell(Checkbox(
                                                    value: true,
                                                    onChanged: (b) {},
                                                  )),*/
                                                  DataCell(InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Alisfatayrinti(
                                                                    e)),
                                                      ).then((e) {
                                                        e != 1
                                                            ? print("gggg")
                                                            : APIServices
                                                                    .odefatal()
                                                                .then((value) {
                                                                Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {
                                                                  setState(() {
                                                                    lis = value;

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
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        e.fataciklama
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  )),
                                                  DataCell(Text(
                                                      e.duztarih.toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15))),
                                                  DataCell(Column(
                                                    children: [
                                                      Text(
                                                          e.odenecektar ==
                                                                  "null"
                                                              ? e.odenmistar
                                                              : fonk1(
                                                                  e), //e.vadta
                                                          //  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 15)),
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
                                                            e.geneltoplam -
                                                                        e
                                                                            .odendimik !=
                                                                    0
                                                                ? "${e.odendimik}"
                                                                : "Ödendi",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                            "Genel Toplam ${e.geneltoplam}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 15)),
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
                      padding: const EdgeInsets.only(
                          right: 8), //const EdgeInsets.fromLTRB(0, 16, 8.0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            //  Wdgappbarfake(),
                            /* Row(
                              children: [
                                Expanded(child: _dropdownbutton(kasalist)),
                                Expanded(
                                  child: Container(
                                    //   height: 45,
                                    margin: EdgeInsets.all(5),
                                    child: FlatButton(
                                      child: Text('Ödeme'),
                                      color: Colors.grey.shade500,
                                      textColor: Colors.brown,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Mustodeekle(
                                                        widget.dt.cariId,
                                                        widget.dt.cariunvani)));
                                      },
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
                            ),*/
                            //),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: wsize.width / 8,
                                //   height: 45,
                                margin: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Text('Alış Fat. Oluştur'),
                                  color: Colors.grey,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Yenialisfat(
                                                cari: widget.dt,
                                              )),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: wsize.width / 8,
                                //   height: 45,
                                margin: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Text('Ödeme Ekle'),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Tedarodeekle(
                                                widget.dt.cariId,
                                                widget.dt.cariunvani)));
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
                                      Icon(
                                        FontAwesomeIcons.liraSign,
                                        size: 12,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            /* Padding(
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
                                  child: Text('Ekstre Pdf İndir'),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    ekstrepdftedar(widget.dt.cariunvani, lis,
                                            widget.dt.bakiye)
                                        .then((value) {
                                      showAlertDialog(context, value);
                                    });
                                  },
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
                    ),
                  ],
                )),
          ],
        ),
        //      ],
        //      ),
      ),
      //)
    ));
  }
}
