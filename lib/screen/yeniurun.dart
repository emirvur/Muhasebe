import 'package:Muhasebe/controller/uruncontroller.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Yeniurun extends StatefulWidget {
  @override
  _YeniurunState createState() => _YeniurunState();
}
// stok takibi ve kritik stok seviyesinde validator yaz
// //kaydettikten sonra flushbar çıksın

class _YeniurunState extends State<Yeniurun> {
  final _formKey = GlobalKey<FormState>();
  String dropstr = "Adet";
  String strkd = "%18";
  bool stoktakipmi = true;
  bool etkinmi = false;
  String ad;
  String bark;
  num baslastkmi;
  num kritist;
  num vergharali;
  num vergharsat;
  bool _isLoading = false;
  TextEditingController contverdahal;
  TextEditingController contverdahsat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contverdahal = TextEditingController(text: "0.0");
    contverdahsat = TextEditingController(text: "0.0");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contverdahal.dispose();
    contverdahsat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;

    print("ooo");

    return SafeArea(
      child: Scaffold(
          /*   appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Hizmet ve Ürünler >", "Yeni", "Ahmet Seç")),
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
            isLoading: _isLoading,
            progressIndicator: Wdgloadingalert(wsize: wsize),
            child: Row(
              children: [
                Container(
                    color: Colors.black87,
                    width: wsize.width / 5,
                    //    height: 500,
                    child: Wdgdrawer()),
                Expanded(
                  child: SingleChildScrollView(
                    //  child: Expanded(
                    child: Column(children: [
                      Wdgappbar("Yeni Ürün", "", ""),
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
                                                          "Adı",
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
                                                    ad = s;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Ad kısmı boş olamaz";
                                                    }
                                                    return null;
                                                    // validation logic
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
                                                        try {
                                                          _formKey.currentState
                                                              .save();
                                                          setState(() {
                                                            _isLoading = true;
                                                          });
                                                          num z = num.tryParse(
                                                              strkd.substring(
                                                                  1));
                                                          Urun ur = Urun(
                                                              bark.toString(),
                                                              ad,
                                                              1,
                                                              dropstr,
                                                              baslastkmi ?? 0,
                                                              kritist ?? -1,
                                                              vergharali,
                                                              vergharsat,
                                                              z);
                                                          await APIServices
                                                              .urunekle(ur);
                                                          /*  Dtourun dur = Dtourun(
                                                            bark.toString(),
                                                            ad,
                                                            1,
                                                            "kategorisiz",
                                                            dropstr,
                                                            baslastkmi ?? 0,
                                                            kritist ?? -1,
                                                            vergharali,
                                                            vergharsat,
                                                            z);*/
                                                          Get.find<
                                                                  Urunliscontroller>()
                                                              .yeniurun(Dtourun(
                                                                  bark
                                                                      .toString(),
                                                                  ad,
                                                                  1,
                                                                  "kategorisiz",
                                                                  dropstr,
                                                                  baslastkmi ??
                                                                      0,
                                                                  kritist ?? -1,
                                                                  vergharali,
                                                                  vergharsat,
                                                                  z));
                                                          Get.find<
                                                                  Urunliscontroller>()
                                                              .siradegistir(0);
                                                          await Future.delayed(
                                                              Duration(
                                                                  seconds: 3));
                                                          Navigator.of(context)
                                                              .pop();
                                                          Load.showtoast(
                                                              "Başarı ile oluşturuldu");
                                                        } catch (e) {
                                                          Load.showtoast(
                                                              "Bir hata oluştu barkod numarasının eşsiz olmasına dikkat ediniz");
                                                        }
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
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .barcode,
                                                          size: 12,
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Barkod Numarası",
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
                                                    bark = s; //num.tryParse(s);
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Barkod numarası kısmı boş olamaz";
                                                    }
                                                    return null;
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
                                                    print(
                                                        "dropstr gunellendi mi");
                                                    setState(() {
                                                      dropstr = v;
                                                    });
                                                  },
                                                )),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      /*      Padding(
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
                                                          "Stok Takibi",
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
                                                    title: Text('YAPILSIN'),
                                                    value: stoktakipmi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        stoktakipmi =
                                                            !stoktakipmi;
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
                                                    title: Text('YAPILMASIN'),
                                                    value: !stoktakipmi,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        stoktakipmi =
                                                            !stoktakipmi;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      stoktakipmi == true
                                          ? Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Başlangıç Stok Miktarı",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            height: 45,
                                                            child:
                                                                TextFormField(
                                                              onSaved: (s) {
                                                                baslastkmi = num
                                                                    .tryParse(
                                                                        s);
                                                              },
                                                              initialValue:
                                                                  "0,0",
                                                              decoration:
                                                                  const InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder()),
                                                              /*      validator:
                                                                    (value) {

                                                                  // validation logic
                                                                },*/
                                                            ),
                                                          ),
                                                        ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Kritik Stok Uyarısı",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                              //     height: ,
                                                              child:
                                                                  CheckboxListTile(
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                title: Text(
                                                                    'Etkinleştir'),
                                                                value: etkinmi,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    etkinmi =
                                                                        !etkinmi;
                                                                  });
                                                                },
                                                              )),
                                                        ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                  etkinmi == true
                                                      ? Container(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    //        Expanded(  flex: 1,child: Icon(Icons.bar_chart_outlined)),
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child: Text(
                                                                            "")),
                                                                    Expanded(
                                                                      flex: 4,
                                                                      child:
                                                                          Container(
                                                                        //   height: 45,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 45,
                                                                              //  color: Colors.grey,
                                                                              decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.black)),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Kritik Stok Seviyesi",
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 45,
                                                                                child: TextFormField(
                                                                                  onSaved: (s) {
                                                                                    kritist = num.tryParse(s);
                                                                                  },
                                                                                  decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.zero))),
                                                                                  validator: (value) {
                                                                                    // validation logic
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Wdgfakebutton()
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 1,
                                                                        child: Text(
                                                                            "")),
                                                                    Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Text(
                                                                          "Stok, belirttiğiniz seviyenin altına düştüğünde e-posta ve mobil uygulamamız aracılığı ile haberdar edilir, ürün liste ve sayfalarında kritik miktardaki ürünlerinizi görebilirsiniz.",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontStyle: FontStyle.italic),
                                                                        )),
                                                                    Wdgfakebutton()
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Text("")
                                                ],
                                              ),
                                            )
                                          : Text(""),
                                      Divider(
                                        color: Colors.black,
                                      ),*/
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
                                                          "KDV",
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
                                                  value: strkd,
                                                  items: <String>[
                                                    '%18',
                                                    '%8',
                                                    '%1',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {
                                                    setState(() {
                                                      strkd = _;
                                                      print("tt");
                                                      print(strkd.substring(1));

                                                      num t = num.tryParse(
                                                          strkd.substring(1));
                                                      print(vergharsat
                                                          .toString());
                                                      print("uu");
                                                      num y = vergharsat +
                                                          (vergharsat *
                                                              (t / 100));

                                                      /*      vergharsat ??
                                                          0 +
                                                              (vergharsat ??
                                                                      0 * t) %
                                                                  100;*/
                                                      num z = vergharali +
                                                          (vergharali *
                                                              (t / 100));
                                                      /*  vergharali ??
                                                          0 +
                                                              (vergharali ??
                                                                  0 *
                                                                      (t %
                                                                          100));*/

                                                      contverdahsat.text =
                                                          y.toString();
                                                      contverdahal.text =
                                                          z.toString();
                                                    });
                                                  },
                                                )),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
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
                                                          "Vergiler Hariç Alış Fiyatı",
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
                                                  onChanged: (s) {
                                                    setState(() {
                                                      vergharali =
                                                          num.tryParse(s);
                                                      print(vergharali
                                                          .toString());
                                                      num t = num.tryParse(
                                                          strkd.substring(1));

                                                      print(t.toString());

                                                      num y = vergharali +
                                                          (vergharali *
                                                              (t / 100));

                                                      contverdahal.text =
                                                          y.toString();
                                                    });
                                                  },
                                                  initialValue: "0,0",
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
                                                          "Vergiler Hariç Satış Fiyatı",
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
                                                  onChanged: (s) {
                                                    setState(() {
                                                      vergharsat =
                                                          num.tryParse(s);
                                                      num t = num.tryParse(
                                                          strkd.substring(1));
                                                      num y = vergharsat +
                                                          (vergharsat *
                                                              (t / 100));

                                                      contverdahsat.text =
                                                          y.toString();
                                                    });
                                                  },
                                                  initialValue: "0,0",
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
                                      Divider(
                                        color: Colors.black,
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
                                                          "Vergiler Dahil Alış Fiyatı",
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
                                                  controller: contverdahal,
                                                  //   initialValue: "0,0",
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
                                                          "Vergiler Dahil Satış Fiyatı",
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
                                                  controller: contverdahsat,
                                                  //      initialValue: "0,0",
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
                                    ],
                                  ),
                                ),
                              ])))
                    ] //),
                        ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
