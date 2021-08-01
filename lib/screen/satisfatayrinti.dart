import 'package:Muhasebe/controller/gdhafta.controller.dart';
import 'package:Muhasebe/controller/gdnuguncontroller.dart';
import 'package:Muhasebe/controller/gunceldurumcontroller.dart';
import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/controller/mustlistcontroller.dart';
import 'package:Muhasebe/controller/satisfatcontroller.dart';
import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';

import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/tahsput.dart';

import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/pdf.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class Satisfatayrinti extends StatefulWidget {
  final Dtofattahs dt;
  Satisfatayrinti(this.dt);
  @override
  _SatisfatayrintiState createState() => _SatisfatayrintiState();
}

class _SatisfatayrintiState extends State<Satisfatayrinti> {
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
  num alinm = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alinm = widget.dt.alinmism;
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController(
        text: (widget.dt.geneltoplam - widget.dt.alinmism).toString());
    Future.wait([
      APIServices.tahsharfaticin(widget.dt.tahsid),
      APIServices.kasalistal(),
      APIServices.fatuurundetay(widget.dt.fatid)
    ]).then((value) {
      setState(() {
        _isloading = false;
        ltah = value[0];
        kasalist = value[1];
        kas = kasalist[0];
        lis = value[2];
      });
    });
  }

  launchEmailSubmission(String fatad, String y) async {
    List<Cari> c = await APIServices.mustara(widget.dt.cariad);
    final Uri params =
        Uri(scheme: 'mailto', path: 'emirvur97@gmail.com', queryParameters: {
      'subject': 'On Muhasebe uygulaması bilgilendirme',
      'body':
          'Buse Tekstil firmasına $fatad adlı satış faturasından $y Tl borcunuzu ödemenizi talep ederiz.İyi günler'
    });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
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
            anchorpdf(pdf, "satisfat");
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
            Expanded(
              flex: 78,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wdgappbar("Satışlar >", "Satış Faturası", ""),
                  ),
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
                                            child: Text(widget.dt.katad),
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
                                        widget.dt.cariad,
                                        style: TextStyle(fontSize: 18),
                                      ),
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
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.format_list_numbered),
                                    Text(widget.dt.cariId.toString()),
                                  ],
                                ),
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
                                        ' Miktar',
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
                                            DataCell(Text(
                                              e.ad,
                                              style: TextStyle(fontSize: 18),
                                            )),
                                            DataCell(Text(
                                              e.miktar.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              Load.numfor
                                                  .format((e.brfiyat).round()),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.vergi.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              Load.numfor.format((e.brfiyat +
                                                      (e.brfiyat * e.vergi) /
                                                          100)
                                                  .round()),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              Load.numfor.format(
                                                  (widget.dt.aratop).round()),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        )
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(widget.dt.kdv.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold)),
                                        )
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              Load.numfor.format(
                                                  (widget.dt.geneltoplam)
                                                      .round()),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold)),
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          "Kalan     ${Load.numfor.format((widget.dt.geneltoplam - alinm).round())}TL",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold)),
                    ),
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
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            "Müşteriden Tahsilat   ${Load.numfor.format(ltah[index].alinmismik)} TL",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              )
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wdgappbarfake(),
                    ),
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
                                  Text(
                                    'Paylaş',
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              onPressed: () {
                                /*  setState(() {
                                  _isloading = true;
                                });
                                createPDF1("test", lis).then((value) {
                                  setState(() {
                                    _isloading = false;
                                  });
                                  showAlertDialog(context, value);
                                });
                               */
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
                                setState(() {
                                  _isloading = true;
                                });
                                createPDF1(widget.dt.cariad, widget.dt.duztarih,
                                        widget.dt, lis)
                                    .then((value) {
                                  setState(() {
                                    _isloading = false;
                                  });
                                  showAlertDialog(context, value);
                                });
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
                              (widget.dt.geneltoplam - alinm) == 0
                                  ? Icon(Icons.verified,
                                      color: Colors.greenAccent)
                                  : Text(""),
                              (widget.dt.geneltoplam - alinm == 0)
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
                                                  text:
                                                      "${Load.numfor.format(alinm)} ",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)
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
                                                      " ${Load.numfor.format(widget.dt.geneltoplam - alinm)}",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)
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
                              height: 40,
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
                                  FlatButton.icon(
                                      onPressed: () async {
                                        launchEmailSubmission(
                                            widget.dt.fataciklama,
                                            Load.numfor
                                                .format((widget.dt.geneltoplam -
                                                        alinm)
                                                    .round())
                                                .toString());
                                        /*    widget.dt.durum == 1
                                            ? {}
                                            : await launchEmailSubmission(
                                                widget.dt.fataciklama,
                                                Load.numfor
                                                    .format(
                                                        (widget.dt.geneltoplam -
                                                                alinm)
                                                            .round())
                                                    .toString(),
                                              );*/
                                      },
                                      icon: Icon(Icons.mail),
                                      label: Text(
                                        "Tahsilat Talep Et",
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: widget.dt.durum == 1
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ))
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
                                                            " ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
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
                                                        (widget.dt.geneltoplam -
                                                            alinm)) {
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
                                            child: Text(
                                              'Vazgeç',
                                              //   style: TextStyle(fontSize: 15),
                                            ),
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
                                            child: Text(
                                              'Tahsilat Ekle',
                                              //   style: TextStyle(fontSize: 15)
                                            ),
                                            color: Colors.white,
                                            textColor: Colors.blue,
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                print("ggg");
                                                _formKey.currentState.save();

                                                try {
                                                  setState(() {
                                                    _isloading = true;
                                                  });
                                                  Tahsput tp = Tahsput(
                                                      widget.dt.tahsid,
                                                      deger,
                                                      widget.dt.geneltoplam,
                                                      selectedDate.toString(),
                                                      kas.kasaid,
                                                      conacik.text);
                                                  bool b = await APIServices
                                                      .tahsharguncelle(tp);
                                                  print(b.toString());
                                                  ltah.add(Dtotahsharfat(
                                                      -1,
                                                      widget.dt.tahsid,
                                                      selectedDate
                                                          .toString(), //         pickedDate.toString(),
                                                      kas.kasaid,
                                                      conacik.text,
                                                      deger,
                                                      widget.dt.cariad));

                                                  Get.find<Mustliscontroller>()
                                                      .mustbakguncel(
                                                          widget.dt.cariId,
                                                          deger);
                                                  widget.dt.geneltoplam -
                                                              alinm ==
                                                          0
                                                      ? widget.dt.durum = 1
                                                      : widget.dt.durum =
                                                          widget.dt.durum;
                                                  Get.find<KasaController>()
                                                      .guncelle(
                                                          kas.kasaid, deger);
                                                  setState(() {
                                                    alinm = alinm + deger;
                                                    Get.find<
                                                            Satisfatcontroller>()
                                                        .guncelle(
                                                            widget.dt.fatid,
                                                            deger);

                                                    Get.find<
                                                            Satisfatcontroller>()
                                                        .siradegistir(0);
                                                    Get.find<
                                                            Mustliscontroller>()
                                                        .siradegistir(0);
                                                  });
                                                  Get.find<
                                                          Gunceldurumcontroller>()
                                                      .aybakiye(deger);
                                                  print("eee");
                                                  Get.find<Gdhaftacontroller>()
                                                      .haftabakiye(deger);
                                                  print("fff");
                                                  Get.find<Gdbuguncontroller>()
                                                      .gunbakiye(deger);
                                                  deger = 0;
                                                  setState(() {
                                                    print("nn");
                                                    _isloading = false;
                                                    Load.showtoast(
                                                        "İşlem başarı ile tamamlandı");
                                                    tahsilform = false;
                                                  });
                                                } catch (e) {
                                                  setState(() {
                                                    _isloading = false;
                                                    Load.showtoast(
                                                        "Bir hata oluştu");
                                                  });
                                                }
                                                //    Navigator.of(context).pop();
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
