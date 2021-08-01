import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:flutter/material.dart';

class Yenimusteri extends StatefulWidget {
  @override
  _YenimusteriState createState() => _YenimusteriState();
}

class _YenimusteriState extends State<Yenimusteri> {
  final _formKey = GlobalKey<FormState>();
  String dropstr = "Adet";
  String strkd = "%18";
  String firmunv;
  String kisais;
  String epos;
  String tel;
  String fak;
  String iban;
  String adres;
  String tckn;
  bool tuzelmi = true;
  @override
  Widget build(BuildContext context) {
    print("yenimusste build");
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          /*   appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Müşteriler >", "Yeni", "Ahmet Seç")),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .black87, //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(child: Wdgdrawer()),
          ),*/
          backgroundColor: Colors.grey.shade300,
          body: Row(
            children: [
              Container(
                  color: Colors.black87,
                  width: wsize / 5,
                  //    height: 500,
                  child: Wdgdrawer()),
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    //  child: Expanded(
                    child: Column(children: [
                      Wdgappbar("wwww", "gggg", "qqqsw"),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              //  color: Colors.white,
                              child: Column(children: [
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
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Firma Unvanı",
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
                                                    firmunv = s;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                    if (value.isEmpty) {
                                                      return "Firma Unvanı boş olamaz";
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
                                                    textColor: Colors.black,
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
                                                    color: Colors.grey.shade700,
                                                    textColor: Colors.white,
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        _formKey.currentState
                                                            .save();
                                                        Cari car = Cari(
                                                            -1,
                                                            firmunv,
                                                            kisais,
                                                            1,
                                                            epos,
                                                            tel,
                                                            fak,
                                                            iban,
                                                            adres,
                                                            tuzelmi == true
                                                                ? 0
                                                                : 1,
                                                            tckn,
                                                            0);
                                                        await APIServices
                                                            .musteriekle(car);
                                                        Navigator.of(context)
                                                            .pop(1);
                                                      }
                                                    },
                                                  ),
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
                                                          "Kısa İsim",
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
                                                //   width: 45,
                                                child: TextFormField(
                                                  onSaved: (s) {
                                                    kisais = s;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                    if (value.isEmpty) {
                                                      return "Kısa isim boş olamaz";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Kategorisi",
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
                                                flex: 1,
                                                child: Chip(
                                                  label: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          Text("Kategorisiz")),
                                                )),
                                            Expanded(flex: 3, child: Text("")),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      /*     Padding(
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
                                                            "Alış/Satış Birimi",
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
                                                  child: DropdownButton<String>(
                                                    value: dropstr,
                                                    items: <String>[
                                                      'Adet',
                                                      'Kilogram',
                                                      'Litre',
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (v) {
                                                      dropstr = v;
                                                    },
                                                  )),
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
                                                          "E-posta adresi",
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
                                                    epos = s;
                                                  },
                                                  //       initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Telefon Numarası",
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
                                                    tel = s;
                                                  },
                                                  //     initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Faks Numarası",
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
                                                    fak = s;
                                                  },
                                                  //     initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Iban Numarası",
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
                                                    iban = s;
                                                  },
                                                  //     initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Türü",
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
                                                    title: Text('Tüzel Kişi'),
                                                    value: tuzelmi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        tuzelmi = !tuzelmi;
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
                                                    title: Text('Gerçek Kişi'),
                                                    value: !tuzelmi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        tuzelmi = !tuzelmi;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Açık Adres",
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
                                                    adres = s;
                                                  },
                                                  //     initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      Divider(),
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
                                                          "VKN/TCKN",
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
                                                    tckn = s;
                                                  },
                                                  //     initialValue: "0,0",
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),

                                      // AÇILIŞ BAKİYE EKLE
                                    ],
                                  ),
                                ),
                              ])))
                    ]),
                    //   ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
