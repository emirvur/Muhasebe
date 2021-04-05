import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Yenialisfatui extends StatefulWidget {
  @override
  _YenialisfatuiState createState() => _YenialisfatuiState();
}

class _YenialisfatuiState extends State<Yenialisfatui> {
  final _formKey = GlobalKey<FormState>();
  bool ischeck = false;
  List lis = [1];
  bool irsa = false;
  bool odendimi = false;
  bool tahsedilce = false;
  List<Kasa> ksl = [];
  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);
  List<Cari> liscar = [];
  List<Dtourun> lisurun;
  bool _isloading = false;
  TextEditingController conmus;
  TextEditingController conur;
  TextEditingController conur2;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String fatacik = "";
  String tahsacik = "";
  Dtourun urun = Dtourun(0, "", 1, "", "", 0, 0, 0, 0, 0);
  Dtourun urun2 = Dtourun(1, "", 1, "", "", 0, 0, 0, 0, 0);

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
    liscar = await APIServices.tedara(ar);
  }

  urunara(String ar) async {
    lisurun = await APIServices.urunara(ar);
  }

  @override
  Widget _dropdownbutton(List<Kasa> userlist) {
    return Container(
      height: 60,
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
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Giderler >", "Yeni Fiş Fatura", "Ahmet Seç")),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .black87, //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(child: Wdgdrawer()),
          ),
          backgroundColor: Colors.grey.shade300,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            //   color: Colors.white,
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
                                                        child: Icon(
                                                          Icons.file_copy,
                                                          color: Colors.brown,
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          " Açıklama",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.brown,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                //         height: 45,
                                                child: TextFormField(
                                                  onSaved: (v) {
                                                    fatacik = v;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Açıklama kısmı boş olamaz";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Vazgeç'),
                                                    color: Colors.white,
                                                    textColor: Colors.grey,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                      child: Text('Kaydet'),
                                                      color:
                                                          Colors.grey.shade700,
                                                      textColor: Colors.white,
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey.currentState
                                                              .save();
                                                          num x = urun.adet *
                                                              (urun.verharsat +
                                                                  urun.verharsat *
                                                                      urun.kdv);
                                                          num y = urun2.adet *
                                                              (urun2.verharsat +
                                                                  urun2.verharsat *
                                                                      urun2
                                                                          .kdv);
                                                          /*       Postfatura pf = Postfatura(
                                                              0,
                                                              fatacik,
                                                              cari.cariId,
                                                              pickedduztar
                                                                  .toString(),
                                                              1,
                                                              urun.verharsat +
                                                                  urun2
                                                                      .verharsat,
                                                              0,
                                                              urun.kdv +
                                                                  urun2.kdv,
                                                              x + y,
                                                              null,
                                                              odendimi == true
                                                                  ? kas.kasaid
                                                                  : 1,
                                                              odendimi == true
                                                                  ? 1
                                                                  : 0,
                                                              pickedDate
                                                                  .toString(),
                                                              pickedDate
                                                                  .toString(),
                                                              "",
                                                              odendimi == true
                                                                  ? x + y
                                                                  : 0,
                                                              x + y);
                                                          bool h =
                                                              await APIServices
                                                                  .faturaekle(
                                                                      pf);
                                                          print(h);*/
                                                          //   Dtofattahs fat=Dtofattahs(fatid, fatTur, durum, cariId, cariad, duztarih, fataciklama, katad, aratop, araind, kdv, geneltoplam, vadta, alta, alinmism, tahsid)
                                                          Navigator.of(context)
                                                              .pop(1);
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 20, color: Colors.black),
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
                                                          "Tedarikçi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                //   height: 50,
                                                //   width: 45,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
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
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder()),
                                                      validator: (value) {
                                                        // validation logic
                                                      },
                                                    ),
                                                    cari.cariunvani != "ss"
                                                        ? Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                "Bu müşterinin bakiyesi : ${cari.bakiye}"),
                                                          )
                                                        : Text("")
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "İrsaliye",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 2,
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
                                                        "İrsaliyeli Fatura"),
                                                    value: irsa,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        irsa = !irsa;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 2,
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
                                                        "Irsaliyesiz Alış"),
                                                    value: !irsa,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        irsa = !irsa;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                          "Fiş Fatura Tarihi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                                      trailing: Icon(
                                                          Icons.calendar_today),
                                                      //onTap: _pickDate1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                      ),
                                      /*       Padding(
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
                                                          "Fiş Fatura numarası",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                      ),*/
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
                                                          "Ödeme Durumu",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text("Ödenecek"),
                                                    value: !odendimi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        odendimi = !odendimi;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //   height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text("Ödendi"),
                                                    value: odendimi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        odendimi = !odendimi;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                      ),
                                      odendimi == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                "Ödendiği tarih ve hesab",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ],
                                                      ))),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 60,
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
                                                                " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                            trailing: Icon(Icons
                                                                .calendar_today),
                                                            onTap: _pickDate,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: _dropdownbutton(
                                                          kasalist)
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          :
                                          //     Divider(),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                "Ödeneceği Tarih",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ],
                                                      ))),
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
                                                                " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                            trailing: Icon(Icons
                                                                .calendar_today),
                                                            onTap: _pickDate1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),

                                //   Container(height: 40, color: Colors.grey[200]),
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
                                                  //fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold
                                                  //    fontStyle:
                                                  //   FontStyle.italic
                                                  ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text('Miktar',
                                                style: TextStyle(
                                                    //fontSize: 18,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                    //    fontStyle:
                                                    //   FontStyle.italic
                                                    )),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Birim',
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
                                              'Br. Fiyat',
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
                                              'Vergi',
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
                                              'Toplam',
                                              style: TextStyle(
                                                  //fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold
                                                  //    fontStyle:
                                                  //   FontStyle.italic
                                                  ),
                                            ),
                                          ),
                                        ],
                                        rows: <DataRow>[
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
                                                urun.verharsat.toString() ??
                                                    "")),
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
                                                urun2.verharsat.toString() ??
                                                    "")),
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
                                                Text(
                                                  "Ara Toplam",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${urun.verharsat + urun2.verharsat}",
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
                                                  "Toplam Kdv ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${urun.kdv + urun2.kdv}",
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
                                                  "${(1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))) + 1 * (urun.verharsat + (urun.verharsat * urun.kdv))}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
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
