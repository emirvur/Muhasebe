import 'package:Muhasebe/controller/alisfatcontroller.dart';
import 'package:Muhasebe/controller/gdhafta.controller.dart';
import 'package:Muhasebe/controller/gdnuguncontroller.dart';
import 'package:Muhasebe/controller/gunceldurumcontroller.dart';
import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/controller/tedarliscontroller.dart';
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
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/pdf.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Alisfatayrinti extends StatefulWidget {
  final Dtofatode dt;
  Alisfatayrinti(this.dt);
  @override
  _AlisfatayrintiState createState() => _AlisfatayrintiState();
}

class _AlisfatayrintiState extends State<Alisfatayrinti> {
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
  num odem = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    odem = widget.dt.odendimik;
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController(
        text: (widget.dt.geneltoplam - widget.dt.odendimik).toString());
    print(condeg.text);
    Future.wait([
      APIServices.odeharfaticin(widget.dt.odeid),
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
    print("333");
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: LoadingOverlay(
        isLoading: _isloading,
        opacity: 0.0,
        progressIndicator: Wdgloadingalert(wsize: wsize),
        child: Row(
          children: [
            Expanded(
              flex: 78,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wdgappbar("Giderler >", "Alış Faturası", ""),
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
                                              Load.numfor
                                                  .format(e.brfiyat.round())
                                                  .toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.vergi.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              /*Load.numfor.format(
                                                  //  (e.brfiyat +
                                                  //        (e.brfiyat * e.vergi) /
                                                  //            100)
                                                  (e.brfiyat +
                                                          (e.brfiyat *
                                                                  e.vergi) /
                                                              100)
                                                      .round()),*/ //),
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
                                          child: Text(Load.numfor
                                              .format(widget.dt.aratop.round())
                                              .toString()),
                                        )
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            widget.dt.kdv.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            Load.numfor
                                                .format(widget.dt.geneltoplam
                                                    .round())
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          "Kalan    ${Load.numfor.format(widget.dt.geneltoplam.round() - odem.round())}TL",
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
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            "Fiş/Fatura Ödeme  ${Load.numfor.format(ltah[index].odendimik.round())} TL",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wdgappbarfake(),
                    ),
                    tahsilform == false
                        ? Row(
                            children: [
                              Container(
                                //   height: 45,
                                margin: EdgeInsets.all(5),
                                child: FlatButton(
                                  child: Text('Diğer',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration:
                                              TextDecoration.lineThrough)),
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
                                            "${Load.numfor.format(widget.dt.geneltoplam.round())} TL",
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
                                                "${Load.numfor.format(widget.dt.geneltoplam.round() - odem.round())} TL",
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
                                        child: Text(
                                          'Paylaş',
                                          style: TextStyle(
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
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
                                                    child: Text("Tarih"))),
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
                                                            " ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
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
                                                flex: 1, child: Text("Hesap")),
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
                                                flex: 1, child: Text("Meblağ")),
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
                                                            odem) {
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
                                                child: Text("Açıklama")),
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

                                                  try {
                                                    setState(() {
                                                      _isloading = true;
                                                    });

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
                                                    Get.find<
                                                            Alisfatcontroller>()
                                                        .guncelle(
                                                            widget.dt.fatid, x);
                                                    ltah.add(Dtoodeharfat(
                                                        -1,
                                                        widget.dt.odeid,
                                                        selectedDate
                                                            .toString(), //         pickedDate.toString(),
                                                        kas.kasaid,
                                                        acikla,
                                                        x,
                                                        widget.dt.cariad));
                                                    Get.find<KasaController>()
                                                        .guncelle(
                                                            kas.kasaid, -x);
                                                    Get.find<
                                                            Tedarliscontroller>()
                                                        .tedarbakguncel(
                                                            widget.dt.cariId,
                                                            deger);
                                                    print(b.toString());
                                                    widget.dt.geneltoplam -
                                                                odem ==
                                                            0
                                                        ? widget.dt.durum = 1
                                                        : widget.dt.durum =
                                                            widget.dt.durum;
                                                    setState(() {
                                                      odem = odem + deger;
                                                      Get.find<
                                                              Alisfatcontroller>()
                                                          .guncelle(
                                                              widget.dt.fatid,
                                                              x);

                                                      Get.find<
                                                              Alisfatcontroller>()
                                                          .siradegistir(0);
                                                      Get.find<
                                                              Tedarliscontroller>()
                                                          .siradegistir(0);
                                                      Get.find<
                                                              Gunceldurumcontroller>()
                                                          .aybakiye(-deger);
                                                      print("eee");
                                                      Get.find<
                                                              Gdhaftacontroller>()
                                                          .haftabakiye(-deger);
                                                      print("fff");
                                                      Get.find<
                                                              Gdbuguncontroller>()
                                                          .gunbakiye(-deger);
                                                      deger = 0;
                                                      setState(() {
                                                        print("nn");
                                                        _isloading = false;
                                                        Load.showtoast(
                                                            "İşlem başarı ile tamamlandı");
                                                        tahsilform = false;
                                                      });
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      _isloading = false;
                                                      Load.showtoast(
                                                          "Bir hata oluştu");
                                                    });
                                                  }
                                                  //   Navigator.of(context).pop();
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
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
