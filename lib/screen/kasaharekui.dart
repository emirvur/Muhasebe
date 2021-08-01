import 'package:Muhasebe/controller/gdhafta.controller.dart';
import 'package:Muhasebe/controller/gdnuguncontroller.dart';
import 'package:Muhasebe/controller/gunceldurumcontroller.dart';
import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtokasahars.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/kasahar.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgappbarfake.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Kasaharekui extends StatefulWidget {
  final Kasa dt;
  Kasaharekui(this.dt);
  @override
  _KasaharekuiState createState() => _KasaharekuiState();
}

class _KasaharekuiState extends State<Kasaharekui> {
  final _formKey = GlobalKey<FormState>();
  List<Dtokasahar> lis = [];
  // List<Dtotahsharfat> ltah = [];
  bool _isloading = true;
  bool tahsilform = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  Kasa digerkas = Kasa(1, "", 1);
  String acikla = "";
  num deger;
  TextEditingController conacik;
  TextEditingController condeg;
  int flag;
  num gosbak = 0;
  FToast fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("yy");
    print(gosbak.toString());
    gosbak = widget.dt.bakiye;
    print(gosbak.toString());
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController();
    fToast = FToast();
    fToast.init(context);
    Future.wait(
            [APIServices.kasalistal(), APIServices.kasahar(widget.dt.kasaid)])
        .then((value) {
      setState(() {
        _isloading = false;
        kasalist = value[0];
        kas = kasalist[0];
        lis = value[1];
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

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  @override
  Widget digerkasadropdown(List<Kasa> userlist) {
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
          print("66");
          print(value.kasaAd);
          digerkas = value;
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
        //   contar.text =
        //         selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
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
        progressIndicator:
            CircularProgressIndicator(), //Wdgloadingalert(wsize: wsize),
        child: Row(
          children: [
            /*    Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),*/
            Expanded(
              flex: 78,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  //  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Wdgappbar("Kasa ve Bankalar >", widget.dt.kasaAd, ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: wsize.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.monetization_on),
                                ),
                                Text(
                                  widget.dt.kasaAd,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Spacer(),
                                Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
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
                            //    Divider(),
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Container(
                                width: wsize.width,
                                child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.grey.shade200),
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'İşlem Türü',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'İşlem  Tarihi',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'İlgili Fatura adı',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Açıklama',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Meblağ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      /*   DataColumn(
                                        label: Text(
                                          'Bakiye',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),*/
                                    ],
                                    rows: lis
                                        .map((e) => DataRow(cells: [
                                              DataCell(Text(e.durum == 0
                                                  ? "Tedarikçiye Ödeme"
                                                  : e.durum == 1
                                                      ? "Müşteriden Tahsilat"
                                                      : "Diğer İşlem")),
                                              DataCell(Text(
                                                e.durum == 1
                                                    ? e.tediltar.toString()
                                                    : e.durum == 0
                                                        ? e.odenmistar
                                                        : "",
                                                //style: TextStyle(
                                                //      fontWeight:
                                                //            FontWeight.bold),
                                              )),
                                              DataCell(Text(e.durum == 1
                                                      ? e.thfatad
                                                      : e.durum == 0
                                                          ? e.ohfatad
                                                          : "t"
                                                  //  style: TextStyle(
                                                  //    fontWeight:
                                                  //            FontWeight.bold),
                                                  )),
                                              DataCell(Text(
                                                e.durum == 1
                                                    ? e.tahsaciklama.toString()
                                                    : e.durum == 0
                                                        ? e.odaciklama
                                                        : e.miktaraciklamasi,
                                                //style: TextStyle(
                                                //      fontWeight:
                                                //            FontWeight.bold),
                                              )),
                                              DataCell(
                                                Text(e.durum == 1
                                                    ? Load.numfor.format(
                                                        e.alinmismik.round())
                                                    : e.durum == 0
                                                        ? Load.numfor.format(
                                                            e.odendimik.round())
                                                        : Load.numfor.format(
                                                            e.miktar.round())),
                                              ),
                                              // DataCell(Text("-")),
                                            ]))
                                        .toList()),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                            )
                            //         Expanded(child: Text("dd"))

                            //        Divider(),
                            //  Text("dd")
                          ],
                        ),

                        //     color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 22,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Wdgappbarfake(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: tahsilform == false
                            ? Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    width: (MediaQuery.of(context).size.width *
                                            15) /
                                        100,
                                    margin: EdgeInsets.all(5),
                                    child: FlatButton(
                                      child: Text('Diğer Hesaba Transfer Yap'),
                                      color: Colors.grey.shade500,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          tahsilform = true;
                                          flag = 0;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    width: (MediaQuery.of(context).size.width *
                                            15) /
                                        100,
                                    margin: EdgeInsets.all(5),
                                    child: FlatButton(
                                      child: Text('Para Girişi Ekle'),
                                      color: Colors.grey.shade500,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          tahsilform = true;
                                          flag = 1;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    width: (MediaQuery.of(context).size.width *
                                            15) /
                                        100,
                                    margin: EdgeInsets.all(5),
                                    child: FlatButton(
                                      child: Text('Para Çıkışı Ekle'),
                                      color: Colors.grey.shade500,
                                      textColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          tahsilform = true;
                                          flag = 2;
                                        });
                                      },
                                    ),
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
                                        Text(
                                            gosbak
                                                .toString(), //widget.dt.bakiye.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : flag == 1
                                ? Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            "Para Girişi",
                                            style: TextStyle(fontSize: 18),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                      print("uu");
                                                      var x =
                                                          num.tryParse(value);
                                                      if (x == null) {
                                                        return "Lütfen geçerli bir sayı giriniz";
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
                                                    decoration:
                                                        const InputDecoration(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            FlatButton(
                                              child: Text('Vazgeç'),
                                              color: Colors.white,
                                              textColor: Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  print("nn");
                                                  deger = 0;
                                                  acikla = "";
                                                  tahsilform = false;
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text(' Ekle'),
                                              color: Colors.white,
                                              textColor: Colors.blue,
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _formKey.currentState.save();
                                                  try {
                                                    print("giriştee");
                                                    setState(() {
                                                      _isloading = true;
                                                    });
                                                    Kasahar kh = Kasahar(
                                                        -1,
                                                        widget.dt.kasaid,
                                                        null,
                                                        null,
                                                        0,
                                                        2,
                                                        deger,
                                                        acikla);
                                                    await APIServices
                                                        .kasaharekle(kh);
                                                    setState(() {
                                                      print("adsadsdsa");
                                                      print(deger.toString());
                                                      print("rr");
                                                      print(gosbak.toString());
                                                      gosbak = gosbak + deger;
                                                      print(gosbak.toString());
                                                      print(acikla);
                                                      lis.add(Dtokasahar(
                                                          -1,
                                                          2,
                                                          deger,
                                                          acikla ?? "qq",
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null));
                                                      print("oo");
                                                      Get.find<KasaController>()
                                                          .guncelle(
                                                              widget.dt.kasaid,
                                                              deger);
                                                      tahsilform = false;
                                                      Get.find<
                                                              Gunceldurumcontroller>()
                                                          .aybakiye(deger);
                                                      print("eee");
                                                      Get.find<
                                                              Gdhaftacontroller>()
                                                          .haftabakiye(deger);
                                                      print("fff");
                                                      Get.find<
                                                              Gdbuguncontroller>()
                                                          .gunbakiye(deger);
                                                      deger = 0;
                                                      acikla = "";
                                                      setState(() {
                                                        _isloading = false;
                                                        Load.showtoast(
                                                            "İşlem başarı ile tamamlandı");
                                                      });
                                                    });
                                                  } catch (e) {
                                                    setState(() {
                                                      _isloading = false;
                                                      Load.showtoast(
                                                          "Bir hata oluştu");
                                                    });
                                                  }
                                                  //     Navigator.of(context).pop(1);
                                                }
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                : flag == 2
                                    ? Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "Para Çıkışı",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Divider(),
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
                                                          print("uu");
                                                          var x = num.tryParse(
                                                              value);
                                                          if (x == null) {
                                                            return "Lütfen geçerli bir sayı giriniz";
                                                          }
                                                          if (x >
                                                              widget
                                                                  .dt.bakiye) {
                                                            return "Bakiyeden daha büyük bir sayı giremezsiniz";
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
                                                      child: Text("Açıklama*")),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                  child: Text('Vazgeç'),
                                                  color: Colors.white,
                                                  textColor: Colors.grey,
                                                  onPressed: () {
                                                    setState(() {
                                                      print("nn");
                                                      tahsilform = false;
                                                      deger = 0;
                                                      acikla = "";
                                                    });
                                                  },
                                                ),
                                                FlatButton(
                                                    child: Text('Ekle'),
                                                    color: Colors.white,
                                                    textColor: Colors.blue,
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        _formKey.currentState
                                                            .save();
                                                        try {
                                                          print("çıkıştaa");
                                                          setState(() {
                                                            _isloading = true;
                                                          });
                                                          Kasahar kh = Kasahar(
                                                              -1,
                                                              widget.dt.kasaid,
                                                              null,
                                                              null,
                                                              0,
                                                              2,
                                                              -deger,
                                                              acikla);
                                                          await APIServices
                                                              .kasaharekle(kh);
                                                          setState(() {
                                                            print("adsadsdsa");
                                                            print(deger
                                                                .toString());
                                                            print("rr");
                                                            print(gosbak
                                                                .toString());
                                                            gosbak =
                                                                gosbak - deger;
                                                            print(gosbak
                                                                .toString());
                                                            print(acikla);
                                                            lis.add(Dtokasahar(
                                                                -1,
                                                                2,
                                                                -deger,
                                                                acikla ?? "qq",
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null,
                                                                null));
                                                            print("oo");
                                                            Get.find<
                                                                    KasaController>()
                                                                .guncelle(
                                                                    widget.dt
                                                                        .kasaid,
                                                                    -deger);
                                                            tahsilform = false;
                                                            Get.find<
                                                                    Gunceldurumcontroller>()
                                                                .aybakiye(
                                                                    -deger);
                                                            print("eee");
                                                            Get.find<
                                                                    Gdhaftacontroller>()
                                                                .haftabakiye(
                                                                    -deger);
                                                            print("fff");
                                                            Get.find<
                                                                    Gdbuguncontroller>()
                                                                .gunbakiye(
                                                                    -deger);
                                                            deger = 0;
                                                            acikla = "";
                                                            _isloading = false;
                                                            Load.showtoast(
                                                                "İşlem başarı ile tamamlandı");
                                                          });
                                                        } catch (e) {
                                                          _isloading = false;
                                                          Load.showtoast(
                                                              "Bir hata oluştu");
                                                        }
                                                      }
                                                    })
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "Hesaba Transfer",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Divider(),
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
                                                              Text("Tarih"))),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child:
                                                          Text("Diğer Kasa")),
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
                                                      child: Text("Meblağ")),
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
                                                          print("uu");
                                                          var x = num.tryParse(
                                                              value);
                                                          if (x == null) {
                                                            return "Lütfen geçerli bir sayı giriniz";
                                                          }
                                                          if (x >
                                                              widget
                                                                  .dt.bakiye) {
                                                            return "Bakiyeden daha büyük bir sayı giremezsiniz";
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
                                                      child: Text("Açıklama")),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                  child: Text('Vazgeç'),
                                                  color: Colors.white,
                                                  textColor: Colors.grey,
                                                  onPressed: () {
                                                    setState(() {
                                                      print("nn");
                                                      tahsilform = false;
                                                      deger = 0;
                                                      acikla = "";
                                                    });
                                                  },
                                                ),
                                                FlatButton(
                                                    child: Text('Transfer et'),
                                                    color: Colors.white,
                                                    textColor: Colors.blue,
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        _formKey.currentState
                                                            .save();
                                                        try {
                                                          setState(() {
                                                            _isloading = true;
                                                          });
                                                          print("ee");
                                                          Kasahar kh = Kasahar(
                                                              -1,
                                                              widget.dt.kasaid,
                                                              null,
                                                              null,
                                                              0,
                                                              2,
                                                              -deger,
                                                              acikla);
                                                          print("rrre");
                                                          Kasahar digerkh =
                                                              Kasahar(
                                                                  -1,
                                                                  kas.kasaid,
                                                                  null,
                                                                  null,
                                                                  0,
                                                                  2,
                                                                  deger,
                                                                  acikla);
                                                          print("uu");
                                                          await APIServices
                                                              .kasaharekle(kh);
                                                          print("aaa");
                                                          await APIServices
                                                              .kasaharekle(
                                                                  digerkh);
                                                          setState(
                                                            () {
                                                              print(
                                                                  "adsadsdsa");
                                                              print(deger
                                                                  .toString());
                                                              print("rr");
                                                              print(gosbak
                                                                  .toString());
                                                              gosbak = gosbak -
                                                                  deger;
                                                              print(gosbak
                                                                  .toString());
                                                              print(acikla);
                                                              lis.add(
                                                                  Dtokasahar(
                                                                      -1,
                                                                      2,
                                                                      -deger,
                                                                      acikla ??
                                                                          "qq",
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null));
                                                              print("oo");
                                                              Get.find<
                                                                      KasaController>()
                                                                  .guncelle(
                                                                      widget.dt
                                                                          .kasaid,
                                                                      -deger);
                                                              Get.find<
                                                                      KasaController>()
                                                                  .guncelle(
                                                                      kas.kasaid,
                                                                      deger);
                                                              tahsilform =
                                                                  false;
                                                              deger = 0;
                                                              acikla = "";
                                                              _isloading =
                                                                  false;
                                                              Load.showtoast(
                                                                  "İşlem başarı ile tamamlandı");
                                                            },
                                                          );
                                                        } catch (e) {
                                                          setState(() {
                                                            _isloading = false;
                                                            Load.showtoast(
                                                                "Bir hata oluştu");
                                                          });
                                                        }
                                                      }
                                                    })
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
